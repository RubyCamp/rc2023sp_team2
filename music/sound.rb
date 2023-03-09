require 'dxruby'

sound = Sound.new("./jitensyaninote.mid")

sound_jump = Sound.new("./jump.wav")

sound_ending = Sound.new ("./gameclear.mid")

$rt = RenderTarget.new(448,480)

Window.loop do
        
    if Input.keyPush?(K_Z)
        sound.play
    end

    if Input.keyPush?(K_SPACE)
        sound_jump.play
    end

    if Input.keyPush?(K_RETURN)
        sound_ending.play
    end

    Window.draw(0,0,$rt)
end
