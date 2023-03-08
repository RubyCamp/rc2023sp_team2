module GameTitle
    module_function
    def exec
      Window.draw_font(100, 100, "Push space to start.", $font)
      $scene = GameMain if Input.key_push?(K_SPACE)
    end
end