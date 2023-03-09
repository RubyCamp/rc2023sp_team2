# スクロールサンプルその１(単純ループスクロール)
require 'dxruby'
require './map'


CHIP_SIZE = 32

# 絵のデータを作る
mapimage = []
mapimage.push(Image.load("./images/map_chip_breakable_block.png")) 
mapimage.push(Image.new(32, 32,[100,100,255]))   # 地面背景
mapimage.push(Image.load("./images/map_chip_stable_block.png"))
mapimage.push(Image.load("./images/map_chip_breakable_wall.png")) 
mapimage.push(Image.load("./images/map_chip_stable_wall.png"))

# Fiberを使いやすくするモジュール
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


# 自キャラ
class Player < Sprite
  include FiberSprite
  attr_accessor :mx, :my

  def initialize(x, y, map, target=Window)
    @mx, @my, @map, self.target = x, y, map, target
    super(8.5 * 32, 10 * 32)

    # 肩幅と足元のブロックにぶつかるため位置補正する細工
    self.center_x = 16
    self.center_y = 60
    self.offset_sync = true

    # 人間画像
    self.image = Image.load("./images/toy_hopping_boy2.png")

  end

#重力
G = 1

  # Player#updateすると呼ばれるFiberの中身
  def fiber_proc
    loop do
      ix  = Input.x

      iy =0
      iy += G

     iy -= G if @map[@mx/32, @my/32+1] == 0

        # 押されたチェック
      if @map[@mx/32+ix, @my/32+iy] == 1   # 移動先が平地のときのみ
        # 8フレームで1マス移動
        8.times do
          @mx += ix * 4
          @my += iy * 4
          self.x += ix * 4
         wait # waitすると次のフレームへ    
        end
      end
      elsif @map[@mx/32+ix, @my/32] == 1   # 移動先が平地のときのみ
        # 8フレームで1マス移動
        8.times do
          @mx += ix * 4
          self.x += ix * 4
          wait # waitすると次のフレームへ    
        end
      else
        wait
      end
    end
  end
end

# RenderTarget作成
rt = RenderTarget.new(640-64, 480-64)

# マップの作成
map_base = Map.new("map.dat", mapimage, rt)
# map_sub = Map.new("map_sub.dat", mapimage, rt)

# 自キャラ
player = Player.new(480, 480, map_base, rt)

# 画面内の自キャラ移動範囲
min_x = 0
max_x = 640

Window.loop do
  # 人移動処理
  player.update

  # rtにベースマップを描画
  map_base.draw(player.mx - player.x, player.my - player.y)

  # rtに人描画
  player.draw

  # rtに上層マップを描画
 # map_sub.draw(player.mx - player.x, player.my - player.y)

  # rtを画面に描画
  Window.draw(32, 32, rt)

  # エスケープキーで終了
  break if Input.key_push?(K_ESCAPE)
end
