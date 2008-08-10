package fl.livepreview
{
import flash.display.*;
import flash.external.*;
import flash.utils.*;

/**
* The LivePreviewParent class provides the timeline for a SWC file 	 * or for a compiled clip that is being exported when ActionScript 3.0 	 * is selected.     *	 * <p>When a property is set on a component instance or when a component 	 * instance is resized on the Stage, Flash makes calls to the methods of 	 * this class, which in turn call methods in your component code to set 	 * the properties and to resize the component.</p>	 *	 * <p>In cases where your component must implement a specific action when 	 * it is in live preview mode, use the following code to test for live preview 	 * mode:</p>	 *	 * <listing>var isLivePreview:Boolean = (parent != null &amp;&amp; getQualifiedClassName(parent) == "fl.livepreview::LivePreviewParent");</listing>	 *	 * <p>The LivePreviewParent class supports the definition of a <code>setSize()</code> 	 * method that uses <code>width</code> and <code>height</code> values to resize 	 * a component. If you do not define a <code>setSize()</code> method, this ob
*/
public class LivePreviewParent extends MovieClip
{
	/**
	* The component instance.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public var myInstance : DisplayObject;

	/**
	* Initializes the scale and align modes of the Stage, sets the 		 * <code>myInstance</code> property, resizes <code>myInstance</code> to		 * the proper size and uses the ExternalInterface class to expose 		 * functions to Flash.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function LivePreviewParent ();
	/**
	* Resizes the component instance on the Stage to the specified		 * dimensions, either by calling a user-defined method, or by 		 * separately setting the <code>width</code> and <code>height</code> 		 * properties.		 *		 * <p>This method is called by Flash Player.</p>		 *		 * @param width The new width for the <code>myInstance</code> instance.		 * @param height The new height for the <code>myInstance</code> instance.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function onResize (width:Number, height:Number) : void;
	/**
	* Updates the properties of the component instance.  		 * This method is called by Flash Player when there 		 * is a change in the value of a property. This method		 * updates all component properties, whether or not 		 * they were changed.		 *		 * @param updateArray An array of parameter names and values.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function onUpdate (...updateArray:Array) : void;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		private function updateCollection (collDesc:Object, index:String) : void;
}
}
