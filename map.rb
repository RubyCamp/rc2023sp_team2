class Map
	attr_accessor :selected_chip_klass

	NUM_OF_ESTABLISHED = 5
	CHIP_KLASSES = {
		MapChips::Blank::CHIP_NUM => MapChips::Blank,
		MapChips::BreakableBlock::CHIP_NUM => MapChips::BreakableBlock,
		MapChips::BreakableWall::CHIP_NUM => MapChips::BreakableWall,
		MapChips::StableBlock::CHIP_NUM => MapChips::StableBlock,
		MapChips::StableWall::CHIP_NUM => MapChips::StableWall
	}

	def initialize(dat_path, bg_img_path)
		@dat_path = dat_path
		@bg_img = ImageManager.load_image(bg_img_path)
		@data = parse_dat_file(@dat_path)
		@render_width = @data.first.size * MapChips::Base::WIDTH
		@render_height = @data.size * MapChips::Base::HEIGHT
		@canvas = RenderTarget.new(@render_width, @render_height, C_WHITE)
		@map_px = 0
		@map_py = 0
		@score = 0
		@selected_chip_klass = MapChips::Blank
		@clicked_marks = []
	end

	def update(scroll_dir, clicked_pos, root_panel)
		if render_canvas
		end
	end

	def edit_chip_klass(klass)
		@selected_chip_klass = klass
	end

	def draw(target)
		target.draw(@map_px, @map_py, @canvas)
	end

	# マップエディター専用メソッド
	# マップ編集結果を保存する。
	def save
		File.open(@dat_path, "w") do |f|
			@data.each do |line|
				f.puts line.map{|chip| chip.class::CHIP_NUM }.join(",")
			end
		end
	end

	# マップエディター専用メソッド
	# マップ領域を白紙化する。
	def clear
		@data.each_with_index do |line, map_y|
			next if map_y == 0 || map_y == @data.size - 1
			line.each_with_index do |chip, map_x|
				next if map_x == 0 || map_x == line.size - 1
				@data[map_y][map_x] = MapChips::Blank.new(map_x, map_y)
			end
		end
	end

	private

	def check_edit_clicked(pos)
		return unless pos
		canvas_pos = calc_canvas_pos(pos)
		chip = get_clicked_point_chip(canvas_pos)
		@data[chip.map_y][chip.map_x] = @selected_chip_klass.new(chip.map_x, chip.map_y)
	end

	# ウィンドウ座標系をキャンバス座標系に変換
	def calc_canvas_pos(pos)
		[pos[0] - @map_px, pos[1] - @map_py]

	end

	# 全てのマップチップを更新してキャンバスにレンダリングする。
	# 戻り値として、全てのチップが静止状態にあるかどうかを返す。
	def render_canvas(updatable = true)
		stabled = true
		@canvas.draw(0, 0, @bg_img)
		@data.each do |line|
			line.each do |chip|
				chip.update(@data) if updatable
				chip.draw(@canvas)
				#stabled = false if chip.moving?
			end
		end
	    @clicked_marks.each do |cm|
			cm.update
			cm.draw(@canvas)
		end
		@clicked_marks.delete_if{|cm| cm.disposed? }
		stabled
	end

	# 初期マップデータを読み込んでMapChipsを要素とする2次元配列を生成して返す。
	def parse_dat_file(path)
		result = []
		File.open(path) do |f|
			f.each_with_index do |line, map_y|
				line_ary = []
				line.chomp.split(/\s*,\s*/).map(&:to_i).each_with_index do |chip_num, map_x|
					line_ary << build_map_chip(map_x, map_y, chip_num)
				end
				result << line_ary
			end
		end
		result
	end

	# マップチップ番号から具体的なオブジェクトを生成して返す。
	def build_map_chip(map_x, map_y, chip_num)
		CHIP_KLASSES[chip_num].new(map_x, map_y)
	end
end