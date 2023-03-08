module GameTitle
    module_function
    def exec
        title_img = Image.load("image/title.png")
        Window.draw(0, 0, title_img)
        $scene = GameMain if Input.key_push?(K_SPACE)
    end
end