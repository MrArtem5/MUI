--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local Sprite = {}

function Sprite.new(x, y, frameWidth, frameHeight, image, frameCount, fps, loop, onCycleEnd)
    local self = {}
    self.x = x or 0
    self.y = y or 0
    self.frameWidth = frameWidth or 32
    self.frameHeight = frameHeight or 32
    self.image = image
    self.frameCount = frameCount or 1
    self.fps = fps or 10
    self.loop = (loop == nil) and true or loop
    self.onCycleEnd = onCycleEnd or function() end

    self.currentFrame = 0
    self.timer = 0
    self.playing = true
    self.finished = false

    self.play = function(s)
        s.playing = true
        s.finished = false
        s.currentFrame = 0
        s.timer = 0
    end

    self.stop = function(s)
        s.playing = false
    end

    self.pause = function(s)
        s.playing = false
    end

    self.resume = function(s)
        if not s.finished then s.playing = true end
    end

    self.update = function(s, dt)
        if not s.playing or s.finished then return end
        s.timer = s.timer + dt
        local frameDuration = 1 / s.fps
        while s.timer >= frameDuration do
            s.timer = s.timer - frameDuration
            s.currentFrame = s.currentFrame + 1
            if s.currentFrame >= s.frameCount then
                if s.loop then
                    s.currentFrame = 0
                    s.onCycleEnd()
                else
                    s.currentFrame = s.frameCount - 1
                    s.finished = true
                    s.playing = false
                    s.onCycleEnd()
                    break
                end
            end
        end
    end

    self.draw = function(s)
        if not s.image then return end
        local quad = love.graphics.newQuad(
            s.currentFrame * s.frameWidth, 0,
            s.frameWidth, s.frameHeight,
            s.image:getDimensions()
        )
        love.graphics.setColor(1, 1, 1)
        love.graphics.draw(s.image, quad, s.x, s.y)
    end

    self.setPosition = function(s, nx, ny) s.x = nx or s.x; s.y = ny or s.y end
    self.getPosition = function(s) return s.x, s.y end
    self.setScale = function(s, sx, sy) s.scaleX = sx or 1; s.scaleY = sy or sx or 1 end
    self.getSize = function(s) return s.frameWidth, s.frameHeight end

    return self
end

return Sprite

















--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]