package flash.display
{
	import private.IGraphicsFill;
	import private.IGraphicsData;

	/// Indicates the end of a graphics fill.
	public class GraphicsEndFill extends Object implements IGraphicsFill, IGraphicsData
	{
		/// Creates an object to use with the Graphics.drawGraphicsData() method to end the fill, explicitly.
		public function GraphicsEndFill ();
	}
}
