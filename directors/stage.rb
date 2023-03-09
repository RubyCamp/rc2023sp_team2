module Directors
	# ゲーム本体シーン制御用ディレクターの共通基底クラス
	class Stage < Base
		def initialize
			super
			@stage_name = "stage"
			@dragging = false
			@clicked = false
			@prev_mouse_pos = get_mouse_pos
		end

		def render_frame
#			@map.draw(Window)
			update_mouse_event
            scroll_dir = @dragging ? calc_scroll_dir : nil
            clicked_pos = @clicked ? get_mouse_pos : nil
            @map.update(scroll_dir, clicked_pos, Window)
			@map.draw(0, 0)
#			check_scene_transition
			@prev_mouse_pos = get_mouse_pos
		end

		private

		def update_mouse_event
			@clicked = Input.mouse_push?(M_LBUTTON)
			if Input.mouse_down?(M_RBUTTON)
				if get_mouse_pos != @prev_mouse_pos
					@dragging = true
				end
			else
				@dragging = false
			end
		end

		def calc_scroll_dir
			current_pos = get_mouse_pos
			scroll_x = @prev_mouse_pos[0] - current_pos[0]
			scroll_y = @prev_mouse_pos[1] - current_pos[1]
			[scroll_x, scroll_y]
		end

		def get_mouse_pos
			[Input.mouse_x, Input.mouse_y]
		end

		def check_scene_transition
				@next_stage_director.set_score_history(@stage_name, @map.score)
				@next_stage_director.timer_start
				transition_scene(@next_stage_director)
			#end
		end
	end
end