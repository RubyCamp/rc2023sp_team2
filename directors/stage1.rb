module Directors
	# ゲーム本体（ステージ1）制御用ディレクター
	class Stage1 < Stage
		def initialize
			super
			@stage_name = "player1"
			@map = Map.new("maps/level_1.map", "images/bg_stage1.jpg")
		end
	end
end