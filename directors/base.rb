module Directors
	# シーン（場面）管理用クラスの共通基底クラス
	class Base
		def initialize
			@next_director = self
			@fonts = {
				default: Font.new(18, "ＭＳ 明朝", weight: true),
				timer: Font.new(48),
				score: Font.new(72)
		}
			@score_history = {} # シーンを跨ぐ得点情報を保持するためのハッシュ
		end

		# エンディングシーンへの遷移を簡単にするための空メソッド
	    def timer_start
		end

		# 得点情報を次のシーンへ伝搬させるためのメソッド
		def set_score_history(stage_name, score)
			@score_history[stage_name] = score
		end

		# シーン切り替え実行
		def transition_scene(director)
			@next_director = director
		end

		# メインループから呼ばれる受け口用メソッド。
		# 次のフレームでメインループから呼ばれるディレクターオブジェクトを返す。
		# 画面遷移しない場合はself（現在のディレクター）を返し、画面遷移する際は次の画面を担当するディレクターを
		# 返すことでシーン制御を実現する。
		def play
			render_frame
			@next_director
		end

		# 個々のディレクタークラスでオーバーライドする１フレーム分の描画用メソッド
		def render_frame
			raise "override me."
		end

		private

		# ゲームウィンドウ上の任意のY座標にテキストを描画する。
		# align: テキストのX座標をどこに寄せるか（[中央寄せ: :center, 左寄せ: :left, 右寄せ: :right]）
		# y: 表示するY座標値
		# text: 表示する文字列
		# font_label: 本クラスで定義している@fontsのキー
		# opt: DXRubyのWindow.draw_fontに渡すオプション用ハッシュ
		def draw_font(align, y, text, font_label, opt = {})
			raise "指定されたフォントが@fontsに定義されていませんでした" unless @fonts.has_key?(font_label.to_sym)
			font = @fonts[font_label.to_sym]
			case align
			when :center
				_draw_font_center(y, text, font, opt)
			when :right
				_draw_font_right(y, text, font, opt)
	       	else
				_draw_font_left(y, text, font, opt)
			end
		end

		# 中央寄せテキスト描画
		def _draw_font_center(y, text, font, opt)
			font_width = font.get_width(text)
			x = (Window.width / 2) - (font_width / 2)
			Window.draw_font(x, y, text, font, opt)
		end

		# 左寄せテキスト描画
		def _draw_font_left(y, text, font, opt)
			Window.draw_font(10, y, text, font, opt)
		end

		# 右寄せテキスト描画
		def _draw_font_right(y, text, font, opt)
			font_width = font.get_width(text)
			x = Window.width - font_width - 10
			Window.draw_font(x, y, text, font, opt)
		end
	end
end