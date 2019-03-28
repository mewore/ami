TopBar = {}
TopBar.__index = TopBar

local DRAG_CURSOR = love.mouse.getSystemCursor("sizens")
local DRAG_BEGIN_DISTANCE = 5

local INITIAL_HEIGHT = 32

--- A bar at the top.
function TopBar:create()
   local this = {
      height = INITIAL_HEIGHT,
   }
   setmetatable(this, self)

   return this
end

--- LOVE update handler
function TopBar:update()
   local mouseInfo = love.mouse.registerSolid(self, { shape = { bottomY = self.height } })
   self.isHovered = mouseInfo.isHovered

   if mouseInfo.drag then
      if mouseInfo.dragStarted then
         self.heightOnDragStart = self.height
      end

      if mouseInfo.drag.maxDy >= DRAG_BEGIN_DISTANCE then
         love.mouse.importantCursor = DRAG_CURSOR
         self.height = math.min(love.graphics.getHeight(), math.max(INITIAL_HEIGHT,
            self.heightOnDragStart + mouseInfo.drag.dy))
      end
   end
end

--- LOVE draw handler
function TopBar:draw()
   love.graphics.setColor(0.7, 0.7, 0.9, 0.8)
   love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), self.height)
   love.graphics.reset()
end