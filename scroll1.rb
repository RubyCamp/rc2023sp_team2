# �X�N���[���T���v�����̂P(�P�����[�v�X�N���[��)
require 'dxruby'
require './map'

# �G�̃f�[�^�����
mapimage = []
mapimage.push(Image.load("./images/map_chip_breakable_block.png")) 
mapimage.push(Image.new(32, 32,[100,100,255]))   # �n�ʔw�i
mapimage.push(Image.load("./images/map_chip_stable_block.png"))
mapimage.push(Image.load("./images/map_chip_breakable_wall.png")) #���蔲����
mapimage.push(Image.load("./images/map_chip_stable_block.png"))

# Fiber���g���₷�����郂�W���[��
module FiberSprite
  def initialize(x=0,y=0,image=nil)
    super
    @fiber = Fiber.new do
      self.fiber_proc
    end
  end

  def update
    @fiber.resume
    super
  end

  def wait(t=1)
    t.times{Fiber.yield}
  end
end

# ���L����
class Player < Sprite
  include FiberSprite
  attr_accessor :mx, :my

  def initialize(x, y, map, target=Window)
    @mx, @my, @map, self.target = x, y, map, target
    super(8.5 * 32, 11 * 32)

    # ���͏�ɂ͂ݏo���ĕ`�悳���̂ł��̂Ԃ�ʒu�␳����׍H
    self.center_x = 0
    self.center_y = 16
    self.offset_sync = true

    # �l�ԉ摜
    self.image = Image.load("./images/toy_hopping_boy2.png")

  end

  # Player#update����ƌĂ΂��Fiber�̒��g
  def fiber_proc
    loop do
      ix, iy = Input.x, Input.y

      # �����ꂽ�`�F�b�N
      if ix + iy != 0 and (ix == 0 or iy == 0) and # �i�i���͋p��
         @map[@mx/32+ix, @my/32+iy] == 1   # �ړ��悪���n�̂Ƃ��̂�
        # 8�t���[����1�}�X�ړ�
        8.times do
          @mx += ix * 4
          @my += iy * 4
          self.x +=ix * 4
          wait # wait����Ǝ��̃t���[����        
        end
      else
        wait
      end
    end
  end
end

# RenderTarget�쐬
rt = RenderTarget.new(640-64, 480-64)

# �}�b�v�̍쐬
map_base = Map.new("map.dat", mapimage, rt)
map_sub = Map.new("map_sub.dat", mapimage, rt)

# ���L����
player = Player.new(480, 480, map_base, rt)

# ��ʓ��̎��L�����ړ��͈�
min_x = 0
max_x = 640

Window.loop do
  # �l�ړ�����
  player.update

  # rt�Ƀx�[�X�}�b�v��`��
  map_base.draw(player.mx - player.x, player.my - player.y)

  # rt�ɐl�`��
  player.draw

  # rt�ɏ�w�}�b�v��`��
  map_sub.draw(player.mx - player.x, player.my - player.y)

  # rt����ʂɕ`��
  Window.draw(32, 32, rt)

  # �G�X�P�[�v�L�[�ŏI��
  break if Input.key_push?(K_ESCAPE)
end