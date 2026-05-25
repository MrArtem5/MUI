--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local Button = {}

function Button.new(x, y, width, height, text, callback, basicColor, pressedColor, hoveredColor, borderColor, textColor)
    local self = {}

    self.x = x or 0
    self.y = y or 0
    self.width = width or 100
    self.height = height or 50
    self.text = text or "..."
    self.callback = callback or function() end

    self.isHovered = false
    self.isPressed = false
    
    self.basicColor = basicColor or {0.4, 0.4, 0.4}
    self.pressedColor = pressedColor or {0.2, 0.2, 0.2}
    self.hoveredColor = hoveredColor or {0.3, 0.3, 0.3}
    self.borderColor = borderColor or {0.15, 0.15, 0.15}
    self.textColor = textColor or {0.15, 0.15, 0.15}

    self.enabled = true
    self.setEnabled = function(btn, enabled)
        btn.enabled = enabled
    end

    self.update = function(btn)
        local mx, my = love.mouse.getPosition()
        btn.isHovered = mx >= btn.x and mx <= btn.x + btn.width and
                        my >= btn.y and my <= btn.y + btn.height

        if not btn.enabled then
            return
        end
        if btn.isPressed and not love.mouse.isDown(1) then
            btn.isPressed = false
            if btn.isHovered then
                btn.callback()
            end
        elseif love.mouse.isDown(1) and btn.isHovered then
            btn.isPressed = true
        end
    end

    self.draw = function(btn)
        if btn.isPressed then
            love.graphics.setColor(btn.pressedColor)
        elseif btn.isHovered then
            love.graphics.setColor(btn.hoveredColor)
        else
            love.graphics.setColor(btn.basicColor)
        end
        love.graphics.rectangle("fill", btn.x, btn.y, btn.width, btn.height)
        
        love.graphics.setColor(btn.textColor)
        local tw = love.graphics.getFont():getWidth(btn.text)
        local th = love.graphics.getFont():getHeight()
        love.graphics.print(btn.text,
            btn.x + (btn.width - tw) / 2,
            btn.y + (btn.height - th) / 2)
        
        love.graphics.setColor(btn.borderColor)
        love.graphics.rectangle("line", btn.x, btn.y, btn.width, btn.height)
    end
    
    return self
end

return Button




























--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]
