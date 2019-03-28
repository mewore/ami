require "advanced-mouse-input"
require "background"
require "draggable-square"
require "top-bar"

local advancedMouseInput = AdvancedMouseInput:create()
love.mouse.horizontalScrollButtons = { "lshift", "rshift" }

local objects = {
   -- Top
   TopBar:create(),
   DraggableSquare:create(100, 200),
   DraggableSquare:create(120, 150),
   Background:create(),
   -- Bottom
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
   for i = #objects, 1, -1 do
      objects[i]:draw()
   end

   advancedMouseInput:draw()
end
