DraggableSquare = {}
DraggableSquare.__index = DraggableSquare

local HAND_CURSOR = love.mouse.getSystemCursor("hand")
local DRAG_CURSOR = love.mouse.getSystemCursor("sizeall")

local SIZE = 100
local SIZE_MODIFIER = 4
local FILL_OPACITY = 0.3
local HOVERED_FILL_OPACITY = 0.6
local DRAGGED_FILL_OPACITY = 0.8
local LINE_OPACITY = 0.8

local LEFT_MOUSE_BUTTON = 1
local RIGHT_MOUSE_BUTTON = 2
local MIDDLE_MOUSE_BUTTON = 3

local DRAG_BEGIN_DISTANCE = 5
local DRAG_BEGIN_DISTANCE_SQUARED = DRAG_BEGIN_DISTANCE * DRAG_BEGIN_DISTANCE

--- A square that can be dragged around with the mouse.
function DraggableSquare:create(x, y)
   local this = {
      width = SIZE,
      height = SIZE,
      x = x,
      y = y,
      isHovered = false,
      isDragged = false,
   }
   setmetatable(this, self)

   return this
end

function DraggableSquare:enlargeBy(size)
   self.x = self.x - size / 2
   self.y = self.y - size / 2
   self.width = self.width + size
   self.height = self.width
end

--- LOVE update handler
function DraggableSquare:update()
   local mouseInfo = love.mouse.registerSolid(self) and love.mouse.registerSolid(self)
   self.isHovered = mouseInfo.isHovered

   if mouseInfo.isHovered then
      love.mouse.cursor = HAND_CURSOR
      if not mouseInfo.drag then
         self.y = self.y - love.mouse.wheel.dy ^ 3
         self.x = self.x - love.mouse.wheel.dx ^ 3
      end
   end

   self.isDragged = false
   if mouseInfo.drag then
      self.isDragged = true
      if mouseInfo.drag.isDragging or (mouseInfo.drag.button == LEFT_MOUSE_BUTTON
            and mouseInfo.drag.maxSquaredDistance >= DRAG_BEGIN_DISTANCE_SQUARED) then
         love.mouse.importantCursor = DRAG_CURSOR
         self.x = mouseInfo.drag.objectXOnDragStart + mouseInfo.drag.dx
         self.y = mouseInfo.drag.objectYOnDragStart + mouseInfo.drag.dy
      end
   end

   if mouseInfo.dragFinished and mouseInfo.dragFinished.maxSquaredDistance < DRAG_BEGIN_DISTANCE_SQUARED
         and mouseInfo.isHovered then
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
function DraggableSquare:draw()
   local fillOpacity = FILL_OPACITY
   if self.isDragged then
      fillOpacity = DRAGGED_FILL_OPACITY
   elseif self.isHovered then
      fillOpacity = HOVERED_FILL_OPACITY
   end

   love.graphics.setColor(0.9, 0.1, 0, fillOpacity)
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

   love.graphics.setColor(0.9, 0.1, 0, LINE_OPACITY)
   love.graphics.rectangle("line", self.x, self.y, self.width, self.height)

   love.graphics.reset()
end