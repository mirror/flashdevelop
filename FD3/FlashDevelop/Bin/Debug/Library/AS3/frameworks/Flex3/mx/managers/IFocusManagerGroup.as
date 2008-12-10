package mx.managers
{
	/**
	 *  The IFocusManagerGroup interface defines the interface that  *  any component must implement if it is grouped in sets, *  where only one member of the set can be selected at any given time. *  For example, a RadioButton implements IFocusManagerGroup *  because a set of RadioButtons in the same group  *  can only have one RadioButton selected at any one time, *  and the FocusManager will make sure not to give focus to the RadioButtons *  that are not selected in response to moving focus via the Tab key.
	 */
	public interface IFocusManagerGroup
	{
		/**
		 *	The name of the group of controls to which the control belongs.
		 */
		public function get groupName () : String;
		/**
		 *  @private
		 */
		public function set groupName (value:String) : void;
		/**
		 *	A flag that indicates whether this control is selected.
		 */
		public function get selected () : Boolean;
		/**
		 *  @private
		 */
		public function set selected (value:Boolean) : void;

	}
}
