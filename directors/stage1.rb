require_relative '../bomb'

module Directors
	# ゲーム本体（ステージ1）制御用ディレクター
	class Stage1 < Stage
		def initialize
			super
			@stage_name = "player1"
			#@map = Map.new("maps/level_1.map", "images/bg_stage1.jpg")
			# 絵のデータを作る
            mapimage = []
			mapimage.push(Image.load("./images/map_chip_breakable_block.png")) 
			mapimage.push(Image.new(32, 32,[100,100,255]))   # 地面背景
			mapimage.push(Image.load("./images/map_chip_stable_block.png"))
			mapimage.push(Image.load("./images/map_chip_breakable_wall.png")) 
			mapimage.push(Image.load("./images/map_chip_stable_wall.png"))
			rt = RenderTarget.new(640-64, 480-64)
		    @map = Map.new("maps/level_1.map", "images/bg_stage1.jpg", "./maps/map.dat", mapimage, rt)
			@player = Player.new(252, 680, @map)
			@count = 0
			@bombs = []
		end

		def render_frame
			super
			@player.update
			unless @player.vanished?
				@player.draw
				Sprite.draw(@bombs)
			end
			Sprite.check(@player, @bombs)
			Sprite.update(@bombs)
			@player.vanished?
    		
			if @count % 60 == 0
				@bombs << Bomb.new(rand(300)+100, -50, Window)
			end
			@count += 1
		end
	end
end