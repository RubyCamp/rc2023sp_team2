module MapChips
	# 重力の影響を受けず、破壊もできない壁
	class StableWall < Base
		CHIP_NUM = 1

		def initialize(map_x, map_y)
			super
			@image = ImageManager.load_image("images/map_chip_stable_wall.png")
		end
	end
end