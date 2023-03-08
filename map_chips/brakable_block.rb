module MapChips
	# 重力の影響を受け、破壊もできるブロック
	class BreakableBlock < Base
		CHIP_NUM = 2

		def initialize(map_x, map_y)
			super
			@movable = true
			@breakable = true
			@image = ImageManager.load_image("images/map_chip_breakable_block.png")
		end
	end
end