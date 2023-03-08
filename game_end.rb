module GameOver
    module_function
    def exec
      Window.draw_font(100, 100, "GAME OVER! Push space to retry.", $font)
      if Input.key_push?(K_SPACE)
        # 初期化をする
        $scene = GameMain
      end
    end
  end