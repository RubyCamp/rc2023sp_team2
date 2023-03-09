require 'dxruby'

sound = Sound.new("./jitensyaninote.mid")

sound_jump = Sound.new("./jump.wav")

sound_ending = Sound.new ("./gameclear.mid")

$rt = RenderTarget.new(448,480)

Window.loop do
        
    if Input.keyPush?(K_Z)#ｚ押下でＢＧＭ流れる
        sound.play
    elsif Input.keyPush?(K_RETURN)#エンター押下でエンディング
       sound.stop
        sound_ending.play
    end

    if Input.keyPush?(K_SPACE)#space押下でジャンプ効果音
        sound_jump.play
    end

    

    Window.draw(0,0,$rt)
end
