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
			#@movable = false
			#@breakable = false
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


		private

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