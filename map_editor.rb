require 'dxruby'

dat_path = "maps/#{ARGV[0]}.map"
if !File.exist?(dat_path)
	puts "マップデータ<#{dat_path}>が見つかりませんでした。"
	exit
end

require_relative 'image_manager'

# 依存するファイル群を一括でrequireする
Dir.glob("directors/*.rb") {|path| require_relative path }
Dir.glob("map_chips/*.rb") {|path| require_relative path }
require_relative 'map'

Window.width = 544
Window.height = 704
Window.caption = "RubyCamp 2023SP Group2 Game"

# 開始時点で実行する最初のシーンディレクターを生成
current_director = Directors::MapEditor.new
current_director.dat_path = dat_path
current_director.load_map

Window.loop do
	current_director = current_director.play
	break if Input.key_push?(K_ESCAPE) # ESCキー押下でメインループを抜ける
end