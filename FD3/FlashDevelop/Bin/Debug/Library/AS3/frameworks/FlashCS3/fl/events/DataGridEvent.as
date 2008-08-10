package fl.events
{
import flash.events.Event;
import fl.events.ListEvent;

/**
* The DataGridEvent class defines events that are associated with the DataGrid component. 	 * These include the following events:	 * <ul>	 * <li><code>DataGridEvent.COLUMN_STRETCH</code>: dispatched after a user resizes a column horizontally.</li>	 * <li><code>DataGridEvent.HEADER_RELEASE</code>: dispatched after the user presses and releases the mouse on a column header.</li>	 * <li><code>DataGridEvent.ITEM_EDIT_BEGIN</code>: dispatched when an item is ready to be edited.</li>	 * <li><code>DataGridEvent.ITEM_EDIT_BEGINNING</code>: dispatched after the user is prepared to edit an item; this is indicated, 	 * for example, by the user releasing the mouse button when the mouse is over the item.</li>	 * <li><code>DataGridEvent.ITEM_EDIT_END</code>: dispatched when an edit session is ending.</li>	 * <li><code>DataGridEvent.ITEM_FOCUS_IN</code>: dispatched after an item receives focus.</li>	 * <li><code>DataGridEvent.ITEM_FOCUS_OUT</code>: dispatched after an item loses focus.</li>	 * </ul>     *
*/
public class DataGridEvent extends ListEvent
{
	/**
	* The <code>DataGridEvent.COLUMN_STRETCH</code> constant defines the value of the <code>type</code> property         * of a <code>columnStretch</code> event object.          *          * <p>This event has the following properties:</p>         *  <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default         *          behavior to cancel.</td></tr>         *     <tr><td><code>columnIndex</code></td><td>The zero-based index of the header column          *          in the <code>columns</code> array of the DataGrid object.</td></tr>         *     <tr><td><code>currentTarget</code></td><td>The object that is actively processing          *          the event object with an event listener. </td></tr>		 *     <tr><td><code>dataField</code></td><td>The name of the field or property in
	*/
		public static const COLUMN_STRETCH : String;
	/**
	* The <code>DataGridEvent.HEADER_RELEASE</code> constant defines the value of the <code>type</code> property         * of a <code>headerRelease</code> event object.          *          * <p>This event has the following properties:</p>         *  <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default         *          behavior to cancel.</td></tr>         *     <tr><td><code>columnIndex</code></td><td>The zero-based index of the header column          *          in the <code>columns</code> array of the DataGrid object.</td></tr>         *     <tr><td><code>currentTarget</code></td><td>The object that is actively processing          *          the event object with an event listener. </td></tr>         *     <tr><td><code>dataField</code></td><td>The name of the field or proper
	*/
		public static const HEADER_RELEASE : String;
	/**
	* The <code>DataGridEvent.ITEM__EDIT_BEGINNING</code> constant defines the value of the          * <code>type</code> property of an <code>itemEditBeginning</code> event object.          *          * <p>This event has the following properties:</p>         *  <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default         *          behavior to cancel.</td></tr>         *     <tr><td><code>columnIndex</code></td><td>The zero-based index of the header column          *          in the <code>columns</code> array of the DataGrid object.</td></tr>         *     <tr><td><code>currentTarget</code></td><td>The object that is actively processing          *          the event object with an event listener. </td></tr>         *     <tr><td><code>dataField</code></td><td>The name of the fie
	*/
		public static const ITEM_EDIT_BEGINNING : String;
	/**
	* The <code>DataGridEvent.ITEM_EDIT_BEGIN</code> constant defines the value of         * the <code>type</code> property of an <code>itemEditBegin</code> event object.         *          * <p>This event has the following properties:</p>         *  <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default         *          behavior to cancel.</td></tr>         *     <tr><td><code>columnIndex</code></td><td>The zero-based index of the header column          *          in the <code>columns</code> array of the DataGrid object.</td></tr>         *     <tr><td><code>currentTarget</code></td><td>The object that is actively processing          *          the event object with an event listener. </td></tr>         *     <tr><td><code>dataField</code></td><td><code>null</code></td></tr>
	*/
		public static const ITEM_EDIT_BEGIN : String;
	/**
	* The <code>DataGridEvent.ITEM_EDIT_END</code> constant defines the value of the <code>type</code>          * property of an <code>itemEditEnd</code> event object.          *          * <p>This event has the following properties:</p>         *  <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default         *          behavior to cancel.</td></tr>         *     <tr><td><code>columnIndex</code></td><td>The zero-based index of the header column          *          in the <code>columns</code> array of the DataGrid object.</td></tr>         *     <tr><td><code>currentTarget</code></td><td>The object that is actively processing          *          the event object with an event listener. </td></tr>         *     <tr><td><code>dataField</code></td><td>The name of the field or propert
	*/
		public static const ITEM_EDIT_END : String;
	/**
	* The <code>DataGridEvent.ITEM_FOCUS_IN</code> constant defines the value of the <code>type</code>          * property of a <code>itemFocusIn</code> event object.          *          * <p>This event has the following properties:</p>         *  <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default         *          behavior to cancel.</td></tr>         *     <tr><td><code>columnIndex</code></td><td>The zero-based index of the header column          *          in the <code>columns</code> array of the DataGrid object.</td></tr>         *     <tr><td><code>currentTarget</code></td><td>The object that is actively processing          *          the event object with an event listener. </td></tr>         *     <tr><td><code>dataField</code></td><td><code>null</code></td></tr>
	*/
		public static const ITEM_FOCUS_IN : String;
	/**
	* The <code>DataGridEvent.ITEM_FOCUS_OUT</code> constant defines the value of the <code>type</code>         * property of an <code>itemFocusOut</code> event object.          *          * <p>This event has the following properties:</p>         *  <table class="innertable" width="100%">         *     <tr><th>Property</th><th>Value</th></tr>         *     <tr><td><code>bubbles</code></td><td><code>false</code></td></tr>         *     <tr><td><code>cancelable</code></td><td><code>false</code>; there is no default         *          behavior to cancel.</td></tr>         *     <tr><td><code>columnIndex</code></td><td>The zero-based index of the header column          *          in the <code>columns</code> array of the DataGrid object.</td></tr>         *     <tr><td><code>currentTarget</code></td><td>The object that is actively processing          *          the event object with an event listener. </td></tr>         *     <tr><td><code>dataField</code></td><td><code>null</code></td></tr>
	*/
		public static const ITEM_FOCUS_OUT : String;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _dataField : String;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _itemRenderer : Object;
	/**
	* @private (protected)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		protected var _reason : String;

	/**
	* Gets the item renderer for the item that is being edited or the          * header renderer that is being clicked or resized.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get itemRenderer () : Object;

	/**
	* Gets or sets the name of the field or property in the data associated with the column.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get dataField () : String;

	/**
	* @private (setter)         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function set dataField (value:String) : Void;

	/**
	*  Gets the reason the <code>itemEditEnd</code> event was dispatched.          *  This property is only valid for events of type <code>DataGridEvent.ITEM_EDIT_END</code>.         *  <p>The possible values are defined in the DataGridEventReason class.</p>         *         *  @see fl.controls.DataGrid#event:itemEditEnd         *  @see DataGridEventReason         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function get reason () : String;

	/**
	* Creates a new DataGridEvent object with the specified parameters.          *          * @param type The event type; this value indicates the action that caused the event.         *         * @param bubbles Indicates whether the event can bubble up the display list hierarchy.         *         * @param cancelable Indicates whether the behavior associated with the event can be         *        prevented.         *          * @param columnIndex The zero-based index of the column that contains the renderer.         *         * @param rowIndex The zero-based index of the row that contains the renderer.         *         * @param itemRenderer The item renderer for the item that is being edited or the header         *        render that is being clicked or stretched.         *         * @param dataField The name of the field or property in the data associated with the column.         *         * @param reason The reason the <code>itemEditEnd</code> event was dispatched.         *
	*/
		public function DataGridEvent (type:String, bubbles:Boolean =false, cancelable:Boolean =false, columnIndex:int =-1, rowIndex:int =-1, itemRenderer:Object =null, dataField:String =null, reason:String =null);
	/**
	* Returns a string that contains all the properties of the DataGridEvent object. The         * string is in the following format:         *          * <p>[<code>DataGridEvent type=<em>value</em> bubbles=<em>value</em>          * cancelable=<em>value</em> columnIndex=<em>value</em> rowIndex=<em>value</em>         * itemRenderer=<em>value</em> dataField=<em>value</em> reason=<em>value</em></code>]</p>         *         * @return A string that contains all the properties of the DataGridEvent object.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function toString () : String;
	/**
	* Creates a copy of the DataGridEvent object and sets the value of each          * property to match the original.         *         * @return A new DataGridEvent object with parameter values that match those of the original.         *         * @langversion 3.0         * @playerversion Flash 9.0.28.0
	*/
		public function clone () : Event;
}
}
