--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local Panel = {}

function Panel.new(x, y, width, height, color, borderColor, borderRadius)
    local self = {}

    self.x = x or 0
    self.y = y or 0
    self.width = width or 350
    self.height = height or 350
    self.color = color or {0.3, 0.3, 0.3, 0.8}
    self.borderColor = borderColor or {0.2, 0.2, 0.2, 0.9}
    self.borderRadius = borderRadius or 1

    self.children = {}
    self.visible = true

    self.addChild = function(panel, child)
        table.insert(panel.children, child)
    end
    self.removeChild = function(panel, child)
        for i, c in ipairs(panel.children) do
            if c == child then
                table.remove(panel.children, i)
                break
            end
        end
    end
    self.clearChildren = function(panel)
        panel.children = {}
    end
    self.update = function(panel, dt)
        if not panel.visible then return end
        
        for _, child in ipairs(panel.children) do
            if child.update then
                child:update(dt)
            end
        end
    end
    self.draw = function(panel)
        if not panel.visible then return end
        
        love.graphics.setColor(panel.color)
        if panel.borderRadius > 0 then
            love.graphics.rectangle("fill", panel.x, panel.y, panel.width, panel.height, panel.borderRadius)
        else
            love.graphics.rectangle("fill", panel.x, panel.y, panel.width, panel.height)
        end
        
        love.graphics.setColor(panel.borderColor)
        if panel.borderRadius > 0 then
            love.graphics.rectangle("line", panel.x, panel.y, panel.width, panel.height, panel.borderRadius)
        else
            love.graphics.rectangle("line", panel.x, panel.y, panel.width, panel.height)
        end
        
        for _, child in ipairs(panel.children) do
            if child.draw then
                child:draw()
            end
        end
    end
    
    self.isPointInside = function(panel, px, py)
        return px >= panel.x and px <= panel.x + panel.width and
               py >= panel.y and py <= panel.y + panel.height
    end
    
    self.setPosition = function(panel, newX, newY)
        local dx = newX - panel.x
        local dy = newY - panel.y
        panel.x = newX
        panel.y = newY
        
        for _, child in ipairs(panel.children) do
            if child.setPosition then
                child:setPosition(child.x + dx, child.y + dy)
            end
        end
    end
    
    self.setVisible = function(panel, visible)
        panel.visible = visible
    end
    
    self.setSize = function(panel, newWidth, newHeight)
        panel.width = newWidth
        panel.height = newHeight
    end
    
    return self
end

return Panel




--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]