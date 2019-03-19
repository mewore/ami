RedSquare = {}
RedSquare.__index = RedSquare

local HAND_CURSOR = love.mouse.getSystemCursor("hand")

local SIZE = 100
local FILL_OPACITY = 0.3
local HOVERED_FILL_OPACITY = 0.6
local LINE_OPACITY = 0.8

--- A controller that keeps track of an X and Y offset as well as a zoom ratio
function RedSquare:create(x, y)
   local this = {
      width = SIZE,
      height = SIZE,
      x = x,
      y = y,
      isHovered = false,
   }
   setmetatable(this, self)

   return this
end

--- LOVE update handler
function RedSquare:update()
   local mouseInfo = love.mouse.registerSolid(self)
   self.isHovered = mouseInfo.isHovered

   if mouseInfo.isHovered then
      love.mouse.cursor = HAND_CURSOR
      self.y = self.y - love.mouse.wheel.dy ^ 3
   end
end

--- LOVE draw handler
function RedSquare:draw()
   love.graphics.setColor(0.9, 0.1, 0, self.isHovered and HOVERED_FILL_OPACITY or FILL_OPACITY)
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

   love.graphics.setColor(0.9, 0.1, 0, LINE_OPACITY)
   love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

   love.graphics.reset()
end