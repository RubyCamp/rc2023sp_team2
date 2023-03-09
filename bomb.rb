# 敵１
class Bomb < Sprite
    def initialize(x, y, rt)
      super(x, y)
      @rt = rt
      @count = 0
      @hp = 1
      self.collision = [0, 0, 40, 40]
      @image = Image.load("images/bomb.png")
  end
  # 更新
  def update
    # 移動
    self.y += 3
  end

  def hit(obj)
    obj.hp += 1
    self.vanish
  end

  def shot(obj)
    self.vanish
  end

  def draw
    #super
    @rt.draw(self.x, self.y, @image, 1)
 end
end