module MapChips
	# 空白チップ（何もない空間を表現する）
	# ※ 何もない空間なのに画像を読み込んでいるのは、マップエディタでアイコン表示するための都合であり、
	#    マップエディタを考慮しないのであればnilでも良い。
	class Blank < Base
		CHIP_NUM = 0

		def initialize(map_x, map_y)
			super
			@image = ImageManager.load_image("images/map_chip_blank.png")
		end
	end
end