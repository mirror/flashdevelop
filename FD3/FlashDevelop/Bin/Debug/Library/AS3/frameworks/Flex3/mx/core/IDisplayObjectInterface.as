	/**
	 *  @copy flash.display.DisplayObject#globalToLocal()
	 */
	function globalToLocal (point:Point) : Point;
	/**
	 *  @copy flash.display.DisplayObject#localToGlobal()
	 */
	function localToGlobal (point:Point) : Point;
	/**
	 *  @copy flash.display.DisplayObject#getBounds()
	 */
	function getBounds (targetCoordinateSpace:DisplayObject) : Rectangle;
	/**
	 *  @copy flash.display.DisplayObject#getRect()
	 */
	function getRect (targetCoordinateSpace:DisplayObject) : Rectangle;
	/**
	 *  @copy flash.display.DisplayObject#hitTestObject()
	 */
	function hitTestObject (obj:DisplayObject) : Boolean;
	/**
	 *  @copy flash.display.DisplayObject#hitTestPoint()
	 */
	function hitTestPoint (x:Number, y:Number, shapeFlag:Boolean) : Boolean;
