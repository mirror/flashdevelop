package fl.controls.listClasses
{
import fl.controls.ButtonLabelPlacement;
import fl.controls.listClasses.ListData;
import fl.controls.listClasses.ICellRenderer;
import fl.controls.LabelButton;
import fl.core.UIComponent;
import flash.events.Event;
import flash.events.MouseEvent;

/**
* The CellRenderer class defines methods and properties for  	 * list-based components to use to manipulate and display custom 	 * cell content in each of their rows. A customized cell can contain	 * text, an existing component such as a CheckBox, or any class that 	 * you create. The list-based components that use this class include 	 * the List, DataGrid, TileList, and ComboBox components.     *     * @see ICellRenderer     *     * @includeExample examples/CellRendererExample.as     *     * @langversion 3.0     * @playerversion Flash 9.0.28.0
*/
public class CellRenderer extends LabelButton implements ICellRenderer
{
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _listData : ListData;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _data : Object;
	/**
	* @private         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		private static var defaultStyles : Object;

	/**
	* @copy fl.controls.listClasses.ICellRenderer#listData         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get listData () : ListData;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set listData (value:ListData) : Void;

	/**
	* @copy fl.controls.listClasses.ICellRenderer#data         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get data () : Object;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set data (value:Object) : Void;

	/**
	* @copy fl.controls.listClasses.ICellRenderer#selected         *         * @default false         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get selected () : Boolean;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set selected (value:Boolean) : Void;

	/**
	* Creates a new CellRenderer instance.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function CellRenderer ();
	/**
	* @copy fl.core.UIComponent#getStyleDefinition()         *		 * @includeExample ../../core/examples/UIComponent.getStyleDefinition.1.as -noswf		 *         * @see fl.core.UIComponent#getStyle()         * @see fl.core.UIComponent#setStyle()         * @see fl.managers.StyleManager         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public static function getStyleDefinition () : Object;
	/**
	* Specifies the dimensions at which the data should be rendered. 		 * These dimensions affect both the data and the cell that contains it; 		 * the cell renderer uses them to ensure that the data fits the cell and 		 * does not bleed into adjacent cells. 		 *         * @param width The width of the object, in pixels.		 *         * @param height The height of the object, in pixels.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function setSize (width:Number, height:Number) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function toggleSelected (event:MouseEvent) : void;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected function drawLayout () : void;
}
}
