module MapChips
	# 重力の影響を受けるが破壊はできないブロック
	class StableBlock < Base
		CHIP_NUM = 3

		def initialize(map_x, map_y)
			super
			#@movable = true
			@image = ImageManager.load_image("images/map_chip_stable_block.png")
		end
	end
end