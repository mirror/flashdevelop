package flash.text 
{
	import flash.display.DisplayObject;
	public final  class StaticText extends DisplayObject 
	{
		/**
		 * Returns the current text of the static text field. The authoring tool may export multiple text field
		 *  objects comprising the complete text. For example, for vertical text, the authoring tool will create
		 *  one text field per character.
		 */
		public function get text():String;
	}
	
}
