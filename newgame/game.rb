require 'dxruby'

# 定义三个方块类
class Scissors < Sprite
  def initialize(x, y)
    @x = x
    @y = y
    self.collision = [0, 0, 32, 32]
    super(x, y)
    @image = Image.load('scissors.png')
  end
  
  def draw
    Window.draw(@x, @y, @image)
  end

  def hit(player)
      player.image = Image.load('scissors.png')
  end
end

class Rock < Sprite  
  def initialize(x, y)
    @x = x
    @y = y
    super(x, y)
    self.collision = [0, 0, 32, 32]
    @image = Image.load('rock.png')
  end
  
  def draw
    Window.draw(@x, @y, @image)
  end
  
  def hit(player)
      player.image = Image.load('rock.png')
  end
end

class Cloth < Sprite
  def initialize(x, y)
    @x = x
    @y = y
    super(x, y)
    self.collision = [0, 0, 32, 32]
    @image = Image.load('cloth.png')
  end
  
  def draw
    Window.draw(@x, @y, @image)
  end
  
  def hit(player)
      player.image = Image.load('cloth.png')
  end
end