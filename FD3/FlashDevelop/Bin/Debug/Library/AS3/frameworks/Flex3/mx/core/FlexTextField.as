package mx.core
{
	import flash.text.TextField;
	import mx.utils.NameUtil;

	/**
	 *  FlexTextField is a subclass of the Player's TextField class *  and the superclass of UITextField. *  It overrides the <code>toString()</code> method *  to return a string indicating the location of the object *  within the hierarchy of DisplayObjects in the application.
	 */
	public class FlexTextField extends TextField
	{
		/**
		 *  Constructor.	 *	 *  <p>Sets the <code>name</code> property to a string	 *  returned by the <code>createUniqueName()</code>	 *  method of the mx.utils.NameUtils class.</p>	 * 	 *  <p>This string is the name of the object's class concatenated	 *  with an integer that is unique within the application,	 *  such as <code>"UITextField18"</code>.</p>	 *	 *  @see flash.display.DisplayObject#name	 *  @see mx.utils.NameUtil#createUniqueName()
		 */
		public function FlexTextField ();
		/**
		 *  Returns a string indicating the location of this object	 *  within the hierarchy of DisplayObjects in the Application.	 *  This string, such as <code>"MyApp0.HBox5.UITextField18"</code>,	 *  is built by the <code>displayObjectToString()</code> method	 *  of the mx.utils.NameUtils class from the <code>name</code>	 *  property of the object and its ancestors.	 *  	 *  @return A String indicating the location of this object	 *  within the DisplayObject hierarchy. 	 *	 *  @see flash.display.DisplayObject#name	 *  @see mx.utils.NameUtil#displayObjectToString()
		 */
		public function toString () : String;
	}
}
