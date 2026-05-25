-- main.lua
local MUI = require("MUI")

local mainPanel
local moodCheckboxes = {}
local habitCheckboxes = {}
local saveButton
local statsButton
local moodText
local messageText
local currentMood = ""

function love.load()
    local font = love.graphics.newFont("fonts/comic.ttf", 18)
    love.graphics.setFont(font)
    
    love.window.maximize()
    
    local w, h = love.graphics.getWidth(), love.graphics.getHeight()
    
    -- Главная панель
    mainPanel = MUI.Panel.new(
        w/2 - 300, h/2 - 250,
        600, 500,
        {0.05, 0.05, 0.1, 0.95},
        {0.6, 0.3, 0.8, 1},
        15
    )
    
    -- Заголовок
    moodText = {
        draw = function()
            love.graphics.setColor(1, 0.8, 0.3)
            love.graphics.setFont(love.graphics.newFont("fonts/comic.ttf", 28))
            love.graphics.print("🎭 Трекер настроения", mainPanel.x + 50, mainPanel.y + 20)
            love.graphics.setFont(love.graphics.newFont("fonts/comic.ttf", 18))
        end
    }
    
    -- Чекбоксы настроения
    local moods = {"😊 Отлично", "😐 Нормально", "😔 Плохо", "😡 Злой", "😴 Устал"}
    local moodY = 80
    
    for i, mood in ipairs(moods) do
        local cb = MUI.CheckBox.new(
            mainPanel.x + 50, mainPanel.y + moodY,
            22, mood, false,
            function(checked)
                if checked then
                    -- Снимаем все остальные чекбоксы
                    for _, other in ipairs(moodCheckboxes) do
                        if other ~= cb then
                            other:setChecked(false)
                        end
                    end
                    currentMood = mood
                    
                    -- Сообщение в зависимости от настроения
                    if mood == "😊 Отлично" then
                        messageText.text = "🎉 Круто! День удался!"
                    elseif mood == "😐 Нормально" then
                        messageText.text = "👍 Норм, бывает хуже"
                    elseif mood == "😔 Плохо" then
                        messageText.text = "💪 Держись, всё наладится!"
                    elseif mood == "😡 Злой" then
                        messageText.text = "🧘 Вдох-выдох... расслабься"
                    elseif mood == "😴 Устал" then
                        messageText.text = "☕ Отдохни, ты заслужил"
                    end
                end
            end,
            {0.3, 0.3, 0.5},  -- boxColor
            {1, 0.9, 0.4},    -- checkColor (золотой)
            {1, 1, 1},        -- textColor
            {0.6, 0.4, 0.8}   -- borderColor
        )
        table.insert(moodCheckboxes, cb)
        mainPanel:addChild(cb)
        moodY = moodY + 40
    end
    
    -- Разделитель
    local separatorY = moodY + 20
    
    -- Заголовок привычек
    local habitTitle = {
        draw = function()
            love.graphics.setColor(0.5, 0.8, 0.5)
            love.graphics.print("✅ Привычки на сегодня", mainPanel.x + 50, mainPanel.y + separatorY)
        end
    }
    mainPanel:addChild(habitTitle)
    
    -- Чекбоксы привычек
    local habits = {"Выспался", "Позавтракал", "Погулял", "Помог кому-то", "Не пил энергетики"}
    local habitY = separatorY + 30
    
    for i, habit in ipairs(habits) do
        local cb = MUI.CheckBox.new(
            mainPanel.x + 50, mainPanel.y + habitY,
            20, habit, false,
            function(checked)
                if checked and habit == "Не пил энергетики" then
                    print("🔥 Ты молодец!")
                end
            end,
            {0.2, 0.5, 0.2},
            {0.4, 0.9, 0.4},
            {1, 1, 1},
            {0.4, 0.7, 0.4}
        )
        table.insert(habitCheckboxes, cb)
        mainPanel:addChild(cb)
        habitY = habitY + 35
    end
    
    -- Кнопка сохранения
    saveButton = MUI.Button.new(
        mainPanel.x + 50, mainPanel.y + habitY + 20,
        250, 45,
        "💾 Сохранить день",
        function()
            local completed = 0
            for _, cb in ipairs(habitCheckboxes) do
                if cb:getChecked() then completed = completed + 1 end
            end
            
            if currentMood ~= "" then
                print("📝 День сохранён! Настроение: " .. currentMood .. " | Привычек: " .. completed .. "/5")
                messageText.text = "✅ Сохранено! Ты молодец!"
            else
                messageText.text = "⚠️ Выбери настроение сначала!"
            end
        end,
        {0.3, 0.4, 0.6},
        {0.2, 0.3, 0.5},
        {0.4, 0.5, 0.7},
        {0.5, 0.6, 0.9},
        {1, 1, 1}
    )
    mainPanel:addChild(saveButton)
    
    -- Текст для сообщений
    messageText = {
        text = "👋 Выбери своё настроение",
        draw = function()
            love.graphics.setColor(0.8, 0.8, 0.9)
            love.graphics.print(messageText.text, mainPanel.x + 320, mainPanel.y + 30)
        end
    }
    
    mainPanel:addChild(moodText)
    mainPanel:addChild(messageText)
end

function love.update(dt)
    mainPanel:update(dt)
end

function love.draw()
    love.graphics.clear(0.05, 0.05, 0.1)
    mainPanel:draw()
    
    love.graphics.setColor(0.5, 0.5, 0.6)
    love.graphics.print("F11 - полноэкранный режим | ESC - выход", 50, love.graphics.getHeight() - 30)
end

function love.resize(w, h)
    mainPanel:setPosition(w/2 - 300, h/2 - 250)
    
    -- Обновить позиции всех элементов (пришлось бы, но для примера опущу)
end

function love.keypressed(key)
    if key == "f11" then
        local fs = love.window.getFullscreen()
        if not fs then
            love.window.setFullscreen(true, "desktop")
        else
            love.window.setFullscreen(false)
            love.window.maximize()
        end
    elseif key == "escape" then
        love.event.quit()
    end
end