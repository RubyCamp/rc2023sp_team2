require 'dxruby'

# 加载玩家和地图组
require_relative 'game'

# 设置窗口大小
Window.width = 640
Window.height = 480

class Player < Sprite
  attr_accessor :image
  
  def initialize(x, y)
    @image = Image.load("player.png")
    @x = x
    @y = y
    super(x, y)
    self.collision = [0, 0, 32, 32]
    @jumping = false
    @jump_count = 0
  end
  
  def update
    # 处理角色的移动逻辑
    if Input.key_down?(K_LEFT)
      @x -= 5
    elsif Input.key_down?(K_RIGHT)
      @x += 5
    end
    
    if Input.key_down?(K_UP)
      @y -= 5
    elsif Input.key_down?(K_DOWN)
      @y += 5
    end
 
    if Input.key_push?(K_SPACE) && !@jumping
      @jumping = true
      @jump_count = 0
    end

    if @jumping
      if @jump_count < 10 # 上升
        @y -= 8
      elsif @jump_count < 20 # 下降
        @y += 8
      else # 跳跃结束
        @jumping = false
      end
      
      @jump_count += 1
    end

    self.x = @x
    self.y = @y
  end

  def draw
    Window.draw(@x, @y, @image)
  end

  def collides_with_block?(block)
    player_sprite = self.sprite
    block_sprite = block.sprite
    player_sprite.collides_with?(block_sprite)
  end
end

# 创建地图块图片数组

mapimage = []
mapimage.push(Image.new(32, 32, [100, 100, 200])) # 海
mapimage.push(Image.new(32, 32, [50, 200, 50]))   # 平地
mapimage.push(
  Image.new(32, 32, [50, 200, 50])
  .box_fill(13, 0, 18, 28, [200, 50, 50])
)                                                 # 木の根元
mapimage.push(
  Image.new(32, 32, [50, 200, 50])
  .triangle_fill(15, 0, 0, 31, 31, 31, [200, 100,100])
)                                                 # 山
mapimage.push(
  Image.new(32, 32)
  .box_fill(13, 16, 18, 31, [200, 50, 50])
  .circle_fill(16, 10, 8, [0, 255, 0])
)                                                 # 木のあたま

# 定义地图数据
mapdata = [
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,2,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,2,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,2,2,2,2,2,2,0,0,0],
  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
]

# 创建地图精灵数组
mapsprite = []
mapdata.each_with_index do |row, y|
  row.each_with_index do |cell, x|
    mapsprite.push(Sprite.new(x * 32, y * 32, mapimage[cell]))
  end
end

player = Player.new(320, 240)

# 创建方块实例并存入数组
scissors = Scissors.new(100, 100)
rock = Rock.new(200, 200)
cloth = Cloth.new(300, 300)
blocks = [scissors, rock, cloth]

# 渲染循环
Window.loop do
  # 退出循环条件
  break if Input.key_push?(K_ESCAPE)
  
  # 更新玩家和地图精灵
  player.update
  Sprite.draw(mapsprite)
  
  # 绘制玩家
  player.draw

  # 绘制方块并检查是否被玩家触碰
  blocks.each do |block|
    block.draw
#    block.hit(player)
  end
  Sprite.check(player, blocks)
end
