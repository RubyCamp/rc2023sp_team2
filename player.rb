require_relative 'fiber_sprite'

# 自キャラ
class Player < Sprite
    include FiberSprite
    attr_accessor :mx, :my
    attr_accessor :hp
  
    def initialize(x, y, map, target=Window)
      @map, self.target = map, target
      @count = Window.fps
      @hp = 0
      @time = 0
      #@y = y 
      @jumping = false 
      @jump_count = 0
      super(252, 583)
  
      # 肩幅と足元のブロックにぶつかるため位置補正する細工
      self.center_x = 16
      self.center_y = 65
      self.offset_sync = true
  
      # 人間画像
      @image = Image.load("./images/toy_hopping_boy2.png")
      @image1 = @image.flush([255, 200, 50, 30])
      self.collision = [25, 55, 65, 97] # 要調整

      # @ending_director = Ending.new
    end
  
    # Player#updateすると呼ばれるFiberの中身
    def fiber_proc
      loop do
        ix, iy = Input.x, Input.y
  
        # 押されたチェック
        if ix + iy != 0 and (ix == 0 or iy == 0) and # ナナメは却下
           @map[self.x/32+ix, self.y/32+iy] == 0   # 移動先が平地のときのみ
          # 8フレームで1マス移動
          8.times do
            self.x +=ix * 4
            wait # waitすると次のフレームへ        
          end
        else
          wait
        end
        
        if Input.key_push?(K_UP) && !@jumping 
          @jumping = true 
          @jump_count = 0
        end
        if @jumping 
          if @jump_count < 10 # up 
            self.y -= 10
          elsif @jump_count < 20 # down 
            self.y += 10 
          else # jump over 
            @jumping = false 
          end
          @jump_count += 1
        end
      end
    end

    def shot
      puts("hit")
      p @hp
      self.image = @image1
      self.target.draw(self.x, self.y, self.image)
      if @hp >= 2
          self.vanish #三回当たったら消える 
          sleep(0.65) 
          #シーン切り替えたい
          $scene = GameOver
          $scene.exec()
      end
    end

    def draw
      #当たったら色が変わる
      self.image = @image if @time == 0
      @time += 1
      if @time % 25 == 0
        self.image = @image
      end
      self.target.draw(self.x, self.y, self.image)
      @count -= 1
    end
end