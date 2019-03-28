# ami
Advanced Mouse Input (not really that advanced actually but eh)


## Type definitions

#### `love.mouse.registerSolid(object: table, [options: Options])` return value
- **isHovered** (`boolean`)
- **clickCount** (`int`) - The total number of clicks this object has received.
- **clicksPerButton** (`(MouseClick[] | nil)[]`) - For every mouse button (1=left, 2=right, 3=middle) there is 
an array of the mouse clicks at its corresponding index, or `nil` if there are no clicks.
- **dragStarted** (`DragInfo | nil`) - Present only when a drag has started at this update.
- **drag** (`DragInfo | nil`) - Present as long as drag is ongoing. It is not present at the moment when the drag has
ended.
- **dragCancelled** (`DragInfo | nil`) - Present if the drag has been cancelled (another drag has just begun,
interrupting it, or the )
- **dragConfirmed** (`DragInfo | nil`) - Present if the drag has ended with a normal release of the same button it has
been initiated with.
- **dragFinished** (`DragInfo | nil`) - Present if the drag has either been cancelled or confirmed.

#### `Options`
- **isWholeScreen** (`boolean`) Whether the object always covers the whole screen.
- **shape** (`{[leftX]: number, [topY]: number, [rightX]: number, [bottomY]: number}`) A custom rectangular shape to be
used for the hover check. If, for example, `leftX` is `nil`, then the shape is considered to extend infinitely to the
left.

#### `MouseClick` ([mousepressed](https://love2d.org/wiki/love.mousepressed) event)
- **x** (`int`) The X position of the cursor (distance from the left border of the window), in pixels.
- **y** (`int`) The Y position of the cursor (distance from the top border of the window), in pixels.
- **isTouch** (`boolean`) True if the mouse button press originated from a touchscreen touch-press.
- **presses** (`int`) The number of presses in a short time frame and small area, used to simulate double, triple
clicks.

#### `DragInfo`
- **button** (`int`) The mouse button with which the drag is being made.
- **fromX** (`int`) The X position of the click from which the drag has begun, in pixels.
- **fromY** (`int`) The Y position of the click from which the drag has begun, in pixels.
- **objectXOnDragStart** (`number`) The X position of the object when the drag was started.
- **objectYOnDragStart** (`number`) The Y position of the object when the drag was started.
- **maxDx** (`int`) The maximum absolute difference between the drag start and the cursor X position.
- **maxDy** (`int`) The maximum absolute difference between the drag start and the cursor Y position.
- **maxSquaredDistance** (`int`) The maximum squared distance between the drag start and the cursor position.
- **toX** (`int`) The current cursor X position.
- **toY** (`int`) The current cursor Y position.
- **lastUpdateCounter** (`int`) An artificially added "update counter" used to determine if there is a skip
between two `registerSolid` calls.
- **dx** (`int`) The current absolute difference between the drag start and the cursor X position.
- **dy** (`int`) The current absolute difference between the drag start and the cursor Y position.
- **squaredDistance** (`int`) The current squared distance between the drag start and the cursor position.
