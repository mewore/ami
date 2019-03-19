require "advanced-mouse-input"
require "red-square"

local advancedMouseInput = AdvancedMouseInput:create()
love.mouse.horizontalScrollButtons = { "lshift", "rshift" }

local objects = {
   RedSquare:create(100, 200),
   RedSquare:create(120, 150),
}

--- LOVE update handler
function love.update()
   if love.keyboard.isDown("escape") then
      love.event.quit()
   end

   advancedMouseInput:beforeUpdate()

   for i = 1, #objects do
      objects[i]:update()
   end

   advancedMouseInput:afterUpdate()
end

--- LOVE draw handler
function love.draw()
   love.graphics.clear(1, 1, 1, 1)

   for i = #objects, 1, -1 do
      objects[i]:draw()
   end

   advancedMouseInput:draw()
end
