package mx.managers
{
	import flash.display.DisplayObject;
	import mx.core.IFlexDisplayObject;

	/**
	 *  @private
	 */
	public interface IPopUpManager
	{
		public function createPopUp (parent:DisplayObject, className:Class, modal:Boolean = false, childList:String = null) : IFlexDisplayObject;
		public function addPopUp (window:IFlexDisplayObject, parent:DisplayObject, modal:Boolean = false, childList:String = null) : void;
		public function centerPopUp (popUp:IFlexDisplayObject) : void;
		public function removePopUp (popUp:IFlexDisplayObject) : void;
		public function bringToFront (popUp:IFlexDisplayObject) : void;
	}
}
