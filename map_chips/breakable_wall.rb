module MapChips
	# 重力の影響は受けないが破壊できる壁
	class BreakableWall < Base
		CHIP_NUM = 4

		def initialize(map_x, map_y)
			super
			@breakable = true
			@image = ImageManager.load_image("images/map_chip_breakable_wall.png")
		end
	end
end