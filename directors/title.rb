module Directors
	# タイトルシーン制御用ディレクター
	class Title < Base
		def initialize
			super
			@bg_img = ImageManager.load_image("images/title.png")
			@stage1_director = Stage1.new
		end

		def render_frame
			draw_background
			check_scene_transition
		end

		private

		# シーンの背景を描画
		def draw_background
			Window.draw(0, 0, @bg_img)
		end

		# マウス左クリックまたはスペースキーが押されたらシーン遷移を実行する
		def check_scene_transition
			if Input.key_push?(K_SPACE)
				@stage1_director.timer_start
				transition_scene(@stage1_director)
			end
		end
	end
end