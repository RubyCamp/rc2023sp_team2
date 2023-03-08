module MapChips
	# マップチップの共通基底クラス
	class Base
		WIDTH = 32  # マップチップの横幅（Pixel）
		HEIGHT = 32 # マップチップの縦幅（Pixel）

		attr_reader :image, :movable, :breakable, :map_x, :map_y
		attr_accessor :editor_px, :editor_py

		def initialize(map_x, map_y)
			@map_x, @map_y = map_x, map_y
			@px = @map_x * WIDTH
			@py = @map_y * HEIGHT
			@movable = false
			@breakable = false
			@destination_py = @py
			@speed = 3
		end

		# チップの1フレーム分の動作を更新する
		def update(map_data)
			move(map_data) if @movable
		end

		# チップを描画する。
		# ※ ただし、空白チップは描画せず、キャンバス背景を透過させる。
		def draw(canvas)
			canvas.draw(@px, @py, @image) unless is_blank_chip?
		end

		# チップが落下中かどうかを返す
		def moving?
			@py != @destination_py
		end

		# チップを消失させる
		def vanish(map_data)
			map_data[@map_y][@map_x] = Blank.new(@map_x, @map_y)
		end

		private

		# チップの移動処理
		def move(map_data)
			if moving?
				# 移動中の場合は移動を継続
				move_to_destination(map_data)
			else
				# 移動していない場合は自身の真下のチップ情報を参照し、自由落下するかしないかを判定
				under_chip = detect_under_chip(map_data)
				if under_chip.is_blank_chip?
					@destination_py = (@map_y + 1) * HEIGHT
				end
			end
		end

		# 現在の目的高度まで1フレーム分の自由落下運動を実行
		def move_to_destination(map_data)
			if @py + @speed >= @destination_py
				@py = @destination_py
				map_data[@map_y][@map_x] = Blank.new(@map_x, @map_y)
				@map_y = @py / HEIGHT
				map_data[@map_y][@map_x] = self
			else
				@py += @speed
			end
		end

		# 自身の真下にあるチップを得る
		def detect_under_chip(map_data)
			line = map_data[@map_y + 1]
			line[@map_x]
		end

		protected

		# チップ自身（self）が空白チップか否かを返す。
		# ※ protectedメソッドの利用例として。
		def is_blank_chip?
			self.class == Blank
		end
	end
end