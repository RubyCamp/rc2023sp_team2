require 'dxruby'

x = 20                        # x座標の変数
y = 40                        # y座標の変数
image = Image.load("./images/map_chip_breakable_block.png") # data.pngを読み込む


radPerFrame = Math::PI * 2 / 60
i = 0


Window.loop do                # メインループ
  x = x + Input.x              # 横方向の入力でx座標を変更
  y = y + Input.y              # 縦方向の入力でy座標を変更

 
  if Input.key_push?(K_SPACE)
  while (i <= 60)
  y += (Math.sin(radPerFrame * i)* 10) * -1
  i += 1
  end
  end

  Window.draw(x, y, image)     # data.bmpを座標の位置に表示
end

