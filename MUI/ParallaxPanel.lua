--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local ParallaxPanel = {}

function ParallaxPanel.new(x, y, width, height, layers, borderColor, borderRadius)
    local self = {}
    self.x = x or 0
    self.y = y or 0
    self.width = width or 400
    self.height = height or 300
    self.layers = layers or {}
    self.borderColor = borderColor or {0.2, 0.2, 0.2}
    self.borderRadius = borderRadius or 0

    self.children = {}
    self.visible = true
    self.clipChildren = true

    self._mx = 0
    self._my = 0

    self.addChild = function(pp, child)
        table.insert(pp.children, child)
    end

    self.removeChild = function(pp, child)
        for i, c in ipairs(pp.children) do
            if c == child then
                table.remove(pp.children, i)
                break
            end
        end
    end

    self.update = function(pp, dt)
        if not pp.visible then return end
        local mx, my = love.mouse.getPosition()
        local cx = pp.x + pp.width/2
        local cy = pp.y + pp.height/2
        pp._mx = (mx - cx) / pp.width
        pp._my = (my - cy) / pp.height

        for _, child in ipairs(pp.children) do
            if child.update then
                child:update(dt)
            end
        end
    end

    self.draw = function(pp)
        if not pp.visible then return end

        love.graphics.setScissor(pp.x, pp.y, pp.width, pp.height)
        for _, layer in ipairs(pp.layers) do
            local img = layer[1]
            local spdX = layer[2] or 0.1
            local spdY = layer[3] or 0.1
            local alpha = layer[4] or 0.5
            local offsetX = pp._mx * pp.width * spdX
            local offsetY = pp._my * pp.height * spdY
            love.graphics.setColor(1, 1, 1, alpha)
            love.graphics.draw(img, pp.x + offsetX, pp.y + offsetY)
        end

        love.graphics.setColor(0, 0, 0, 0.4)
        love.graphics.rectangle("fill", pp.x, pp.y, pp.width, pp.height)
        love.graphics.setScissor()

        if pp.clipChildren then
            love.graphics.setScissor(pp.x, pp.y, pp.width, pp.height)
        end
        for _, child in ipairs(pp.children) do
            if child.draw then child:draw() end
        end
        if pp.clipChildren then
            love.graphics.setScissor()
        end

        love.graphics.setColor(pp.borderColor)
        if pp.borderRadius > 0 then
            love.graphics.rectangle("line", pp.x, pp.y, pp.width, pp.height, pp.borderRadius)
        else
            love.graphics.rectangle("line", pp.x, pp.y, pp.width, pp.height)
        end
    end

    self.setPosition = function(pp, nx, ny) pp.x = nx or pp.x; pp.y = ny or pp.y end
    self.getPosition = function(pp) return pp.x, pp.y end
    self.setSize = function(pp, w, h) pp.width = w or pp.width; pp.height = h or pp.height end
    self.getSize = function(pp) return pp.width, pp.height end

    return self
end

return ParallaxPanel




--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]