require 'dxruby'
require './map'

# �G�̃f�[�^�����
# mapimage = []
# mapimage.push(Image.load("./images/map_chip_breakable_block.png")) 
# mapimage.push(Image.new(32, 32,[100,100,255]))   # �n�ʔw�i
# mapimage.push(Image.load("./images/map_chip_stable_block.png"))
# mapimage.push(Image.load("./images/map_chip_breakable_wall.png")) 
# mapimage.push(Image.load("./images/map_chip_stable_wall.png"))

# RenderTarget�쐬
# rt = RenderTarget.new(640-64, 480-64)

# �}�b�v�̍쐬
# map_base = Map.new("map.dat", mapimage, rt)
# map_sub = Map.new("map_sub.dat", mapimage, rt)

# ���L����
# player = Player.new(480, 480, map_base, rt)

# ��ʓ��̎��L�����ړ��͈�
# min_x = 0
# max_x = 640

Window.loop do
  # �l�ړ�����
  
  # rt�Ƀx�[�X�}�b�v��`��
  # map_base.draw(player.mx - player.x, player.my - player.y)

  # rt�ɐl�`��
  

  # rt�ɏ�w�}�b�v��`��
  # map_sub.draw(player.mx - player.x, player.my - player.y)

  # rt����ʂɕ`��
  # Window.draw(32, 32, rt)

  # �G�X�P�[�v�L�[�ŏI��
  break if Input.key_push?(K_ESCAPE)
end
