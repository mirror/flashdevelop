package mx.managers
{
	/**
	 *  The IFocusManagerComponent interface defines the interface 
 *  that focusable components must implement in order to
 *  receive focus from the FocusManager.
 *  The base implementations of this interface are in the UIComponent class, 
 *  but UIComponent does not implement the full IFocusManagerComponent interface 
 *  since some UIComponents are not intended to receive focus.
 *  Therefore, to make a UIComponent-derived component be a valid focusable
 *  component, you simply add "implements IFocusManagerComponent" to the class
 *  definition.
	 */
	public interface IFocusManagerComponent
	{
		/**
		 *  A flag that indicates whether the component can receive focus when selected.
	 * 
	 *  <p>As an optimization, if a child component in your component 
	 *  implements the IFocusManagerComponent interface, and you
	 *  never want it to receive focus,
	 *  you can set <code>focusEnabled</code>
	 *  to <code>false</code> before calling <code>addChild()</code>
	 *  on the child component.</p>
	 * 
	 *  <p>This will cause the FocusManager to ignore this component
	 *  and not monitor it for changes to the <code>tabEnabled</code>,
	 *  <code>tabChildren</code>, and <code>mouseFocusEnabled</code> properties.
	 *  This also means you cannot change this value after
	 *  <code>addChild()</code> and expect the FocusManager to notice.</p>
	 *
	 *  <p>Note: It does not mean that you cannot give this object focus
	 *  programmatically in your <code>setFocus()</code> method;
	 *  it just tells the FocusManager to ignore this IFocusManagerComponent
	 *  component in the Tab and mouse searches.</p>
		 */
		public function get focusEnabled () : Boolean;
		/**
		 *  @private
		 */
		public function set focusEnabled (value:Boolean) : void;

		/**
		 *  A flag that indicates whether the component can receive focus 
	 *  when selected with the mouse.
	 *  If <code>false</code>, focus will be transferred to
	 *  the first parent that is <code>mouseFocusEnabled</code>.
		 */
		public function get mouseFocusEnabled () : Boolean;

		/**
		 *  A flag that indicates whether pressing the Tab key eventually 
	 *  moves focus to this component.
	 *  Even if <code>false</code>, you can still be given focus
	 *  by being selected with the mouse or via a call to
	 *  <code>setFocus()</code>
		 */
		public function get tabEnabled () : Boolean;

		/**
		 *  If <code>tabEnabled</code>, the order in which the component receives focus.
	 *  If -1, then the component receives focus based on z-order.
		 */
		public function get tabIndex () : int;

		/**
		 *  Called by the FocusManager when the component receives focus.
	 *  The component may in turn set focus to an internal component.
		 */
		public function setFocus () : void;

		/**
		 *  Called by the FocusManager when the component receives focus.
	 *  The component should draw or hide a graphic 
	 *  that indicates that the component has focus.
	 *
	 *  @param isFocused If <code>true</code>, draw the focus indicator,
	 *  otherwise hide it.
		 */
		public function drawFocus (isFocused:Boolean) : void;
	}
}
