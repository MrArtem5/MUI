--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local CircularProgress = {}

function CircularProgress.new(x, y, radius, value, max, fgColor, bgColor, glow)
    local self = {}
    self.x = x or 0
    self.y = y or 0
    self.radius = radius or 40
    self.value = value or 0
    self.max = max or 100
    self.fgColor = fgColor or {0.3, 0.8, 0.3}
    self.bgColor = bgColor or {0.2, 0.2, 0.2}
    self.glow = (glow == nil) and true or glow
    self._smoothValue = self.value

    self.setValue = function(cp, v)
        cp.value = math.min(math.max(v, 0), cp.max)
    end

    self.getValue = function(cp) return cp.value end

    self.update = function(cp, dt)
        cp._smoothValue = cp._smoothValue + (cp.value - cp._smoothValue) * math.min(10 * dt, 1)
    end

    self.draw = function(cp)
        local fraction = cp._smoothValue / cp.max
        love.graphics.setColor(cp.bgColor)
        love.graphics.circle("fill", cp.x, cp.y, cp.radius)
        if cp.glow and fraction > 0 then
            love.graphics.setColor(cp.fgColor[1], cp.fgColor[2], cp.fgColor[3], 0.2)
            love.graphics.setLineWidth(6)
            love.graphics.arc("line", cp.x, cp.y, cp.radius + 3, -math.pi/2, -math.pi/2 + fraction * math.pi*2)
            love.graphics.setLineWidth(1)
        end
        love.graphics.setColor(cp.fgColor)
        love.graphics.setLineWidth(4)
        love.graphics.arc("line", cp.x, cp.y, cp.radius - 2, -math.pi/2, -math.pi/2 + fraction * math.pi*2)
        love.graphics.setLineWidth(1)
        love.graphics.setColor(1, 1, 1)
        local percent = math.floor(fraction * 100)
        local font = love.graphics.getFont()
        local text = percent .. "%"
        local tw = font:getWidth(text)
        local th = font:getHeight()
        love.graphics.print(text, cp.x - tw/2, cp.y - th/2)
    end

    self.setPosition = function(cp, nx, ny) cp.x = nx or cp.x; cp.y = ny or cp.y end
    self.getPosition = function(cp) return cp.x, cp.y end
    self.setSize = function(cp, r) cp.radius = r or cp.radius end
    self.getSize = function(cp) return cp.radius end

    return self
end

return CircularProgress





































--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]