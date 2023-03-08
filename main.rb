require 'dxruby'

# requirで作成した他のファイルを繋げます
require_relative "game_title"
require_relative "game_main"
require_relative "game_end"

Window.width = 544
Window.height = 704
Window.caption = "RubyCamp 2023SP Group2 Game"

$scene = GameTitle
$font = Font.new(24)

Window.loop do
    $scene.exec()
    break if Input.key_push?(K_ESCAPE) # ESCキー押下でメインループを抜ける
end
