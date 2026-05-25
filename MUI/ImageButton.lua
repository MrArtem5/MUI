--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local ImageButton = {}

function ImageButton.new(x, y, width, height, normalImg, hoverImg, pressImg, callback)
    local self = {}
    self.x = x or 0
    self.y = y or 0
    self.width = width or 64
    self.height = height or 64
    self.normalImg = normalImg
    self.hoverImg = hoverImg or normalImg
    self.pressImg = pressImg or hoverImg or normalImg
    self.callback = callback or function() end

    self.isHovered = false
    self.isPressed = false
    self.enabled = true

    self.setEnabled = function(ib, en)
        ib.enabled = en
        if not en then ib.isPressed = false; ib.isHovered = false end
    end

    self.update = function(ib)
        local mx, my = love.mouse.getPosition()
        ib.isHovered = mx >= ib.x and mx <= ib.x + ib.width and
                       my >= ib.y and my <= ib.y + ib.height
        if not ib.enabled then return end

        if ib.isPressed and not love.mouse.isDown(1) then
            ib.isPressed = false
            if ib.isHovered then
                ib.callback()
            end
        elseif not ib.isPressed and love.mouse.isDown(1) and ib.isHovered then
            ib.isPressed = true
        end
    end

    self.draw = function(ib)
        local img
        if not ib.enabled then
            img = ib.normalImg
            love.graphics.setColor(0.5, 0.5, 0.5)
        elseif ib.isPressed and ib.pressImg then
            img = ib.pressImg
            love.graphics.setColor(1, 1, 1)
        elseif ib.isHovered and ib.hoverImg then
            img = ib.hoverImg
            love.graphics.setColor(1, 1, 1)
        else
            img = ib.normalImg
            love.graphics.setColor(1, 1, 1)
        end
        if img then
            love.graphics.draw(img, ib.x, ib.y, 0, ib.width / img:getWidth(), ib.height / img:getHeight())
        end
        if ib.isHovered and ib.enabled then
            love.graphics.setColor(1, 1, 0, 0.3)
            love.graphics.rectangle("line", ib.x, ib.y, ib.width, ib.height)
        end
    end

    self.setPosition = function(ib, nx, ny) ib.x = nx or ib.x; ib.y = ny or ib.y end
    self.getPosition = function(ib) return ib.x, ib.y end
    self.setSize = function(ib, w, h) ib.width = w or ib.width; ib.height = h or ib.height end
    self.getSize = function(ib) return ib.width, ib.height end

    return self
end

return ImageButton

























--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]