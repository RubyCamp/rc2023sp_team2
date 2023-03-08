module GameOver
    module_function
    def exec
        result_img = Image.load("image/result.png")
        Window.draw(0, 0, result_img)
        Window.draw_font(150, 350, "RESULT:", $font)
        if Input.key_push?(K_SPACE)
            # 初期化をする
            # リプレイ用
            $scene = GameMain
        end
    end
end