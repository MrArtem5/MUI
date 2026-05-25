--MrArtem - библиотека для LOVE2D "MUI" или если полностью - Mister User Interface
local ParticleEmitter = {}

function ParticleEmitter.new()
    local self = {}
    self.particles = {}

    self.emit = function(pe, x, y, count, config)
        config = config or {}
        local cfg = {
            speedMin = config.speedMin or 50,
            speedMax = config.speedMax or 150,
            angleMin = config.angleMin or 0,
            angleMax = config.angleMax or math.pi*2,
            lifetimeMin = config.lifetimeMin or 0.3,
            lifetimeMax = config.lifetimeMax or 0.8,
            sizeStart = config.sizeStart or 4,
            sizeEnd = config.sizeEnd or 1,
            colorStart = config.colorStart or {1,1,0},
            colorEnd = config.colorEnd or {1,0,0},
            gravity = config.gravity or 0,
            spread = config.spread or 0
        }
        for i = 1, count do
            local angle = cfg.angleMin + math.random() * (cfg.angleMax - cfg.angleMin)
            local speed = cfg.speedMin + math.random() * (cfg.speedMax - cfg.speedMin)
            table.insert(pe.particles, {
                x = x,
                y = y,
                vx = math.cos(angle) * speed,
                vy = math.sin(angle) * speed,
                life = cfg.lifetimeMin + math.random() * (cfg.lifetimeMax - cfg.lifetimeMin),
                maxLife = cfg.lifetimeMin + math.random() * (cfg.lifetimeMax - cfg.lifetimeMin),
                sizeStart = cfg.sizeStart,
                sizeEnd = cfg.sizeEnd,
                colorStart = cfg.colorStart,
                colorEnd = cfg.colorEnd,
                gravity = cfg.gravity
            })
        end
    end

    self.update = function(pe, dt)
        for i = #pe.particles, 1, -1 do
            local p = pe.particles[i]
            p.life = p.life - dt
            if p.life <= 0 then
                table.remove(pe.particles, i)
            else
                p.x = p.x + p.vx * dt
                p.y = p.y + p.vy * dt
                p.vy = p.vy + p.gravity * dt
            end
        end
    end

    self.draw = function(pe)
        for _, p in ipairs(pe.particles) do
            local t = 1 - (p.life / p.maxLife) -- от 0 до 1
            local size = p.sizeStart + (p.sizeEnd - p.sizeStart) * t
            local r = p.colorStart[1] + (p.colorEnd[1] - p.colorStart[1]) * t
            local g = p.colorStart[2] + (p.colorEnd[2] - p.colorStart[2]) * t
            local b = p.colorStart[3] + (p.colorEnd[3] - p.colorStart[3]) * t
            love.graphics.setColor(r, g, b, 1 - t)
            love.graphics.circle("fill", p.x, p.y, size)
        end
    end

    self.clear = function(pe)
        pe.particles = {}
    end
    return self
end

return ParticleEmitter























--[[
Создатель библиотеки - MrArtem.
Если вам продали библиотеку не от имени MrArtem'а
или пытались выдать себя за MrArtem'а
то просим обратиться к настоящему создателю MUI, чтобы все выяснить.
Ведь продавец этой библиотеки мог добавить вредоносный файл.
ВСЕГДА перед сделкой узнавайте больше информации в интернете, как все установить,
на проверенных источниках.
--]]