Background = {}
Background.__index = Background

local DRAG_CURSOR = love.mouse.getSystemCursor("sizewe")
local DRAG_BEGIN_DISTANCE = 5

--- The background, with a hint of blue.
function Background:create()
   local this = {
      blueness = 0,
      bluenessOnDragStart = nil,
   }
   setmetatable(this, self)

   return this
end

--- LOVE update handler
function Background:update()
   local mouseInfo = love.mouse.registerSolid(self, { isWholeScreen = true })
   self.isHovered = mouseInfo.isHovered

   if mouseInfo.drag then
      if mouseInfo.dragStarted then
         self.bluenessOnDragStart = self.blueness
      end

      if mouseInfo.drag.maxDx >= DRAG_BEGIN_DISTANCE then
         love.mouse.importantCursor = DRAG_CURSOR
         self.blueness = math.min(1, math.max(0,
            self.bluenessOnDragStart + (mouseInfo.drag.toX - mouseInfo.drag.fromX) / love.graphics.getWidth()))
      end
   end
end

--- LOVE draw handler
function Background:draw()
   love.graphics.clear(1 - self.blueness, 1 - self.blueness, 1)
end