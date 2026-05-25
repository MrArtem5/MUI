--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local CheckBox = {}

function CheckBox.new(x, y, size, text, checked, callback, boxColor, checkColor, textColor, borderColor)
    local self = {}

    self.x = x or 0
    self.y = y or 0
    self.size = size or 20
    self.text = text or ""
    self.checked = checked or false
    self.callback = callback or function() end

    self.isHovered = false
    self.isPressed = false
    
    self.boxColor = boxColor or {0.3, 0.3, 0.4}
    self.boxHoverColor = {0.4, 0.4, 0.5}
    self.boxCheckedColor = {0.3, 0.6, 0.3}
    self.checkColor = checkColor or {0.8, 0.8, 0.8}
    self.textColor = textColor or {1, 1, 1}
    self.borderColor = borderColor or {0.5, 0.5, 0.6}

    self.enabled = true
    self.setEnabled = function(btn, enabled)
        btn.enabled = enabled
    end
    self.update = function(cb)
        local mx, my = love.mouse.getPosition()

        local overBox = mx >= cb.x and mx <= cb.x + cb.size and
                        my >= cb.y and my <= cb.y + cb.size
        
        local textWidth = love.graphics.getFont():getWidth(cb.text)
        local overText = mx >= cb.x + cb.size + 5 and 
                         mx <= cb.x + cb.size + 5 + textWidth and
                         my >= cb.y and my <= cb.y + cb.size
        
        cb.isHovered = overBox or overText
        
        if not cb.enabled then
            return
        end

        if cb.isPressed and not love.mouse.isDown(1) then
            cb.isPressed = false
            if cb.isHovered then
                cb.checked = not cb.checked
                cb.callback(cb.checked)
            end
        elseif love.mouse.isDown(1) and cb.isHovered then
            cb.isPressed = true
        end
    end

    self.draw = function(cb)
        if cb.checked then
            love.graphics.setColor(cb.boxCheckedColor)
        elseif cb.isHovered then
            love.graphics.setColor(cb.boxHoverColor)
        else
            love.graphics.setColor(cb.boxColor)
        end
        love.graphics.rectangle("fill", cb.x, cb.y, cb.size, cb.size)
        
        love.graphics.setColor(cb.borderColor)
        love.graphics.rectangle("line", cb.x, cb.y, cb.size, cb.size)
        
        if cb.checked then
            love.graphics.setColor(cb.checkColor)
            love.graphics.setLineWidth(2)
            
            local offset = cb.size * 0.2
            love.graphics.line(
                cb.x + offset, cb.y + cb.size / 2,
                cb.x + cb.size / 2, cb.y + cb.size - offset,
                cb.x + cb.size - offset, cb.y + offset
            )
            love.graphics.setLineWidth(1)
        end
        
        if cb.text ~= "" then
            love.graphics.setColor(cb.textColor)
            love.graphics.print(cb.text, cb.x + cb.size + 5, cb.y + (cb.size - love.graphics.getFont():getHeight()) / 2)
        end
    end
    
    self.setChecked = function(cb, checked)
        cb.checked = checked
    end
    
    self.getChecked = function(cb)
        return cb.checked
    end
    
    self.setText = function(cb, newText)
        cb.text = newText
    end
    --[[
    Создатель библиотеки - MrArtem.
    Если вам продали библиотеку не от имени MrArtem'а
    или пытались выдать себя за MrArtem'а
    то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
    Ведь продавец этой библиотеки мог добавить вредоносный файл.
    ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
    на проверенных источниках.
    --]]
    self.setPosition = function(cb, newX, newY)
        cb.x = newX
        cb.y = newY
    end
    
    return self
end

return CheckBox
