require 'dxruby'
require './map'

# 絵のデータを作る
# mapimage = []
# mapimage.push(Image.load("./images/map_chip_breakable_block.png")) 
# mapimage.push(Image.new(32, 32,[100,100,255]))   # 地面背景
# mapimage.push(Image.load("./images/map_chip_stable_block.png"))
# mapimage.push(Image.load("./images/map_chip_breakable_wall.png")) 
# mapimage.push(Image.load("./images/map_chip_stable_wall.png"))

# RenderTarget作成
# rt = RenderTarget.new(640-64, 480-64)

# マップの作成
# map_base = Map.new("map.dat", mapimage, rt)
# map_sub = Map.new("map_sub.dat", mapimage, rt)

# 自キャラ
# player = Player.new(480, 480, map_base, rt)

# 画面内の自キャラ移動範囲
# min_x = 0
# max_x = 640

Window.loop do
  # 人移動処理
  
  # rtにベースマップを描画
  # map_base.draw(player.mx - player.x, player.my - player.y)

  # rtに人描画
  

  # rtに上層マップを描画
  # map_sub.draw(player.mx - player.x, player.my - player.y)

  # rtを画面に描画
  # Window.draw(32, 32, rt)

  # エスケープキーで終了
  break if Input.key_push?(K_ESCAPE)
end
