module GameOver
	module_function
    def exec
        result_img = Image.load("images/game_over.png")

		@sound4 = Sound.new("./music_gameclear.mid")
		@sound4.play

		Window.loop do
			Window.draw(0, 0, result_img)
			break if Input.key_push?(K_ESCAPE) # ESCキー押下でメインループを抜ける
		end
    end
end