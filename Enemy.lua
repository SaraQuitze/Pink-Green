--named with capital E to state that it's an object (crappy cramp a videogame where you play a woman during her days, trying to do a normal day)
local love = require "love"

function Enemy(level)
    local dice = math.random(1, 4)
    local _x, _y
    local _radius = 20

    if dice == 1 then
        _x = math.random(_radius, love.graphics.getWidth())
        _y = -_radius * 4
    elseif dice == 2 then
        _x = -_radius * 4
        _y = math.random(_radius, love.graphics.getHeight())
    elseif dice == 3 then
        _x = math.random(_radius, love.graphics.getWidth())
        _y = love.graphics.getHeight() + (_radius * 4)
    else 
        _x = love.graphics.getWidth() + (_radius * 4)
        _y = math.random(_radius, love.graphics.getHeight())
    end
    
    return {
        level = level or 1,
        radius = _radius,
        x = _x,
        y = _y,

        checkTouched = function(self, player_x, player_y, cursor_radius)
            return math.sqrt((self.x - player_x) ^ 2 + (self.y - player_y) ^ 2) <= cursor_radius * 2
        end,

        move = function (self, player_x, player_y)
            if player_x - self.x > 0 then --what we say here is meanwhile the position of the player and the position of the enemy (self) is not the same, the game will keep going, otherwise, game over.
                self.x = self.x + self.level
            elseif player_x - self.x < 0 then
                self.x = self.x - self.level
            end

            if player_y - self.y > 0 then 
                self.y = self.y + self.level
            elseif player_y - self.y < 0 then
                self.y = self.y - self.level
            end
        end,

        draw = function (self)
            love.graphics.setColor(255/255, 105/255, 200/255)
            love.graphics.circle("fill", self.x, self.y, self.radius)
            love.graphics.setColor(1,1,1)
        end
    }
end

return Enemy --this will allow us to export the object to main