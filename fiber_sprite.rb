# Fiberを使いやすくするモジュール
module FiberSprite
    def initialize(x=0,y=0,image=nil)
      super
      @fiber = Fiber.new do
        self.fiber_proc
      end
    end
  
    def update
      @fiber.resume
      super
    end
  
    def wait(t=1)
      t.times{Fiber.yield}
    end
end