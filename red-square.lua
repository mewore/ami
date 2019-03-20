RedSquare = {}
RedSquare.__index = RedSquare

local HAND_CURSOR = love.mouse.getSystemCursor("hand")
local DRAG_CURSOR = love.mouse.getSystemCursor("sizeall")

local SIZE = 100
local SIZE_MODIFIER = 4
local FILL_OPACITY = 0.3
local HOVERED_FILL_OPACITY = 0.6
local LINE_OPACITY = 0.8

local LEFT_MOUSE_BUTTON = 1
local RIGHT_MOUSE_BUTTON = 2
local MIDDLE_MOUSE_BUTTON = 3

local DRAG_BEGIN_DISTANCE = 5
local DRAG_BEGIN_DISTANCE_SQUARED = DRAG_BEGIN_DISTANCE * DRAG_BEGIN_DISTANCE

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

function RedSquare:enlargeBy(size)
   self.x = self.x - size / 2
   self.y = self.y - size / 2
   self.width = self.width + size
   self.height = self.width
end

--- LOVE update handler
function RedSquare:update()
   local mouseInfo = love.mouse.registerSolid(self)
   self.isHovered = mouseInfo.isHovered

   if mouseInfo.isHovered then
      love.mouse.cursor = HAND_CURSOR
      if not mouseInfo.drag then
         self.y = self.y - love.mouse.wheel.dy ^ 3
         self.x = self.x - love.mouse.wheel.dx ^ 3
      end
   end

   if mouseInfo.drag then
      if mouseInfo.drag.isDragging or (mouseInfo.drag.button == LEFT_MOUSE_BUTTON
            and mouseInfo.drag.squaredDistance >= DRAG_BEGIN_DISTANCE_SQUARED) then
         love.mouse.importantCursor = DRAG_CURSOR
         mouseInfo.drag.isDragging = true
         self.x = mouseInfo.drag.objectXOnDragStart + mouseInfo.drag.dx
         self.y = mouseInfo.drag.objectYOnDragStart + mouseInfo.drag.dy
      end
   end

   if mouseInfo.dragFinished and not mouseInfo.dragFinished.isDragging and mouseInfo.isHovered then
      if mouseInfo.dragFinished.button == LEFT_MOUSE_BUTTON then
         self:enlargeBy(2 * SIZE_MODIFIER)
      elseif mouseInfo.dragFinished.button == RIGHT_MOUSE_BUTTON then
         self:enlargeBy(-2 * SIZE_MODIFIER)
      elseif mouseInfo.dragFinished.button == MIDDLE_MOUSE_BUTTON then
         self:enlargeBy(SIZE - self.width)
      end
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