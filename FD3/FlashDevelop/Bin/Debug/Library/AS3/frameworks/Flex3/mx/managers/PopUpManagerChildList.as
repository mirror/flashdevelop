package mx.managers
{
	/**
	 *  The PopUpManagerChildList class defines the constant values for  *  the <code>detail</code> property of the *  PopUpManager <code>addPopUp()</code> and <code>createPopUp()</code>  *  methods. *   *  @see PopUpManager
	 */
	public class PopUpManagerChildList
	{
		/**
		 *  Indicates that the popup is placed in the same child list as the	 *  application.
		 */
		public static const APPLICATION : String = "application";
		/**
		 *  Indicates that the popup is placed in the popup child list	 *  which will cause it to float over other popups in the application	 *  layer.
		 */
		public static const POPUP : String = "popup";
		/**
		 *  Indicates that the popup is placed in whatever child list the	 *  parent component is in.
		 */
		public static const PARENT : String = "parent";

	}
}
