AdvancedMouseInput = {}
AdvancedMouseInput.__index = AdvancedMouseInput

local DEBUG_TEXT_HEIGHT = 16
local NORMAL_CURSOR = love.mouse.getSystemCursor("arrow")

--- A view stack that handles the order in which to order the views and uptates only the top view
function AdvancedMouseInput:create()
   local this = {}
   setmetatable(this, self)
   return this
end

local mouse = love.mouse
mouse.wheel = { dx = 0, dy = 0 }

--- LOVE mouse wheel scroll handler
-- @param dx {int} - The horizontal movement of the wheel scroll
-- @param dy {int} - The vertical movement of the wheel scroll (positive ~ forwards, negative ~ backwards)
function love.wheelmoved(dx, dy)
   mouse.wheel.dx, mouse.wheel.dy = mouse.wheel.dx + dx, mouse.wheel.dy + dy
end

local mouseHoverIsBlocked = false
local hoveredRectangleToDraw

local function isInside(x, y, leftX, topY, rightX, bottomY)
   return (leftX == nil or x >= leftX)
         and (rightX == nil or x <= rightX)
         and (topY == nil or y >= topY)
         and (bottomY == nil or y <= bottomY)
end

--- Whether the mouse (judging by its current position) is inside a rectangle
-- @param leftX {int | nil} - The leftmost (lowest) X of the rectangle
-- @param topY {int | nil} - The topmost (lowest) Y of the rectangle
-- @param rightX {int | nil} - The rightmost (highest) X of the rectangle
-- @param bottomY {int | nil} - The bottom-most (highest) Y of the rectangle
local function mouseIsInside(leftX, topY, rightX, bottomY)
   return not mouseHoverIsBlocked and isInside(mouse.getX(), mouse.getY(), leftX, topY, rightX, bottomY)
end

--- Considers a rectangle solid.
function mouse.registerSolid(object)
   local isHovered = mouseIsInside(object.x, object.y, object.x + object.width, object.y + object.height)
   if isHovered then
      mouseHoverIsBlocked = true
      hoveredRectangleToDraw = object
   end

   return {
      isHovered = isHovered
   }
end

--- Must be called at the very beginning of the LOVE update handler
function AdvancedMouseInput:beforeUpdate()
   mouseHoverIsBlocked = false
   mouse.cursor = NORMAL_CURSOR
end

--- Must be called at the very end of the LOVE update handler
function AdvancedMouseInput:afterUpdate()
   mouse.wheel.dx, mouse.wheel.dy = 0, 0
   mouse.setCursor(mouse.cursor)
end

--- LOVE draw handler (used only for debugging purposes)
function AdvancedMouseInput:draw()
   if hoveredRectangleToDraw then
      love.graphics.setColor(0, 1, 0.5, 0.8)
      love.graphics.rectangle("line", hoveredRectangleToDraw.x, hoveredRectangleToDraw.y,
         hoveredRectangleToDraw.width, hoveredRectangleToDraw.height)
      love.graphics.setColor(0, 0.3, 0.1, 1)
      love.graphics.print("Hovered", hoveredRectangleToDraw.x, hoveredRectangleToDraw.y - DEBUG_TEXT_HEIGHT)

      hoveredRectangleToDraw = nil
      love.graphics.reset()
   end
end