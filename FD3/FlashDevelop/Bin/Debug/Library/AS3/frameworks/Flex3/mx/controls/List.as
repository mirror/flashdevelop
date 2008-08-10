/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.controls.listClasses.ListBase;
	import mx.core.IIMESupport;
	import mx.controls.listClasses.IListItemRenderer;
	import flash.display.Sprite;
	public class List extends ListBase implements IIMESupport {
		/**
		 * A flag that indicates whether or not the user can edit
		 *  items in the data provider.
		 *  If true, the item renderers in the control are editable.
		 *  The user can click on an item renderer to open an editor.
		 */
		public var editable:Boolean = false;
		/**
		 * The column and row index of the item renderer for the
		 *  data provider item being edited, if any.
		 */
		public function get editedItemPosition():Object;
		public function set editedItemPosition(value:Object):void;
		/**
		 * A reference to the item renderer
		 *  in the DataGrid control whose item is currently being edited.
		 */
		public function get editedItemRenderer():IListItemRenderer;
		/**
		 * The name of the property of the item editor that contains the new
		 *  data for the list item.
		 *  For example, the default itemEditor is
		 *  TextInput, so the default value of the editorDataField property is
		 *  "text", which specifies the text property of the
		 *  the TextInput control.
		 */
		public var editorDataField:String = "text";
		/**
		 * The height of the item editor, in pixels, relative to the size of the
		 *  item renderer. This property can be used to make the editor overlap
		 *  the item renderer by a few pixels to compensate for a border around the
		 *  editor.
		 */
		public var editorHeightOffset:Number = 0;
		/**
		 * A flag that indicates whether the item editor uses Enter key.
		 *  If this property is set to true, the item editor uses the Enter key and the
		 *  List will not look for the Enter key and move the editor in
		 *  response.
		 */
		public var editorUsesEnterKey:Boolean = false;
		/**
		 * The width of the item editor, in pixels, relative to the size of the
		 *  item renderer. This property can be used to make the editor overlap
		 *  the item renderer by a few pixels to compensate for a border around the
		 *  editor.
		 */
		public var editorWidthOffset:Number = 0;
		/**
		 * The x location of the upper-left corner of the item editor,
		 *  in pixels, relative to the upper-left corner of the item.
		 *  This property can be used to make the editor overlap
		 *  the item renderer by a few pixels to compensate for a border around the
		 *  editor.
		 */
		public var editorXOffset:Number = 0;
		/**
		 * The y location of the upper-left corner of the item editor,
		 *  in pixels, relative to the upper-left corner of the item.
		 *  This property can be used to make the editor overlap
		 *  the item renderer by a few pixels to compensate for a border around the
		 *  editor.
		 */
		public var editorYOffset:Number = 0;
		/**
		 * Specifies the IME (input method editor) mode.
		 *  The IME enables users to enter text in Chinese, Japanese, and Korean.
		 *  Flex sets the specified IME mode when the control gets focus,
		 *  and sets it back to the previous value when the control loses focus.
		 */
		public function get imeMode():String;
		public function set imeMode(value:String):void;
		/**
		 * The class factory for the item editor to use for the control, if the
		 *  editable property is set to true.
		 */
		public var itemEditor:IFactory;
		/**
		 * A reference to the currently active instance of the item editor,
		 *  if it exists.
		 */
		public var itemEditorInstance:IListItemRenderer;
		/**
		 * cache of measuring objects by factory
		 */
		protected var measuringObjects:Dictionary;
		/**
		 * Specifies whether the item renderer is also an item
		 *  editor. If this property is true, Flex
		 *  ignores the itemEditor property.
		 */
		public var rendererIsEditor:Boolean = false;
		/**
		 * Constructor.
		 */
		public function List();
		/**
		 * Creates the item editor for the item renderer at the
		 *  editedItemPosition using the editor
		 *  specified by the itemEditor property.
		 *
		 * @param colIndex          <int> The column index. Flex sets the value of this property to 0 for a List control.
		 * @param rowIndex          <int> The index in the data provider of the item to be
		 *                            edited.
		 */
		public function createItemEditor(colIndex:int, rowIndex:int):void;
		/**
		 * Get the appropriate renderer, using the default renderer if none specified
		 *
		 * @param data              <Object> 
		 */
		public override function createItemRenderer(data:Object):IListItemRenderer;
		/**
		 * Closes an item editor that is currently open on an item.
		 *  You typically call this method only from within the event listener
		 *  for the itemEditEnd event, after
		 *  you call the preventDefault() method to prevent
		 *  the default event listener from executing.
		 */
		public function destroyItemEditor():void;
		/**
		 * Draws a row background
		 *  at the position and height specified. This creates a Shape as a
		 *  child of the input Sprite and fills it with the appropriate color.
		 *  This method also uses the backgroundAlpha style property
		 *  setting to determine the transparency of the background color.
		 *
		 * @param s                 <Sprite> A Sprite that will contain a display object
		 *                            that contains the graphics for that row.
		 * @param rowIndex          <int> The row's index in the set of displayed rows. The
		 *                            header does not count; the top most visible row has a row index of 0.
		 *                            This is used to keep track of the objects used for drawing
		 *                            backgrounds so that a particular row can reuse the same display object
		 *                            even though the index of the item that the row is rendering has changed.
		 * @param y                 <Number> The suggested y position for the background.
		 * @param height            <Number> The suggested height for the indicator.
		 * @param color             <uint> The suggested color for the indicator.
		 * @param dataIndex         <int> The index of the item for that row in the
		 *                            data provider. For example, this can be used to color the 10th item differently.
		 */
		protected function drawRowBackground(s:Sprite, rowIndex:int, y:Number, height:Number, color:uint, dataIndex:int):void;
		/**
		 * Stops the editing of an item in the data provider.
		 *  When the user finished editing an item, the control calls this method.
		 *  It dispatches the itemEditEnd event to start the process
		 *  of copying the edited data from
		 *  the itemEditorInstance to the data provider and hiding the
		 *  itemEditorInstance.
		 *
		 * @param reason            <String> A constant defining the reason for the event
		 *                            (such as "CANCELLED", "NEW_ROW", or "OTHER").
		 *                            The value must be a member of the ListEventReason class.
		 * @return                  <Boolean> Returns true if preventDefault() is not called.
		 *                            Otherwise, false.
		 */
		protected function endEdit(reason:String):Boolean;
		/**
		 * Determines if the item renderer for a data provider item
		 *  is editable.
		 *
		 * @param data              <Object> The data provider item
		 * @return                  <Boolean> true if the item is editable
		 */
		public function isItemEditable(data:Object):Boolean;
		/**
		 * Positions the item editor instance at the suggested position
		 *  with the suggested dimensions. The Tree control overrides this
		 *  method and adjusts the position to compensate for indentation
		 *  of the renderer.
		 *
		 * @param x                 <int> The suggested x position for the indicator.
		 * @param y                 <int> The suggested y position for the indicator.
		 * @param w                 <int> The suggested width for the indicator.
		 * @param h                 <int> The suggested height for the indicator.
		 */
		protected function layoutEditor(x:int, y:int, w:int, h:int):void;
		/**
		 * Creates a new ListData instance and populates the fields based on
		 *  the input data provider item.
		 *
		 * @param data              <Object> The data provider item used to populate the ListData.
		 * @param uid               <String> The UID for the item.
		 * @param rowNum            <int> The index of the item in the data provider.
		 * @return                  <BaseListData> A newly constructed ListData object.
		 */
		protected function makeListData(data:Object, uid:String, rowNum:int):BaseListData;
	}
}
