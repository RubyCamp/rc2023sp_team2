require 'dxruby'

require_relative 'image_manager'
require_relative 'player'
require_relative 'fiber_sprite'

# 依存するファイル群を一括でrequireする
Dir.glob("directors/*.rb") {|path| require_relative path }
Dir.glob("map_chips/*.rb") {|path| require_relative path }

require_relative 'map'

Window.width = 544
Window.height = 704
Window.caption = "RubyCamp 2023SP Group2 Game"

# ゲーム開始時点で実行する最初のシーンディレクターを生成
current_director = Directors::Title.new

@sound = Sound.new("./music_jitensyaninote.mid")
@sound.play

Window.loop do
	current_director = current_director.play
	
	break if Input.key_push?(K_ESCAPE) # ESCキー押下でメインループを抜ける
end