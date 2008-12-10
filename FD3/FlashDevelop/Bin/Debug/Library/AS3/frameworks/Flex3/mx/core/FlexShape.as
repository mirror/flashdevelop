package mx.core
{
	import flash.display.Shape;
	import mx.utils.NameUtil;

	/**
	 *  FlexShape is a subclass of the Player's Shape class. *  It overrides the <code>toString()</code> method *  to return a string indicating the location of the object *  within the hierarchy of DisplayObjects in the application.
	 */
	public class FlexShape extends Shape
	{
		/**
		 *  Constructor.	 *	 *  <p>Sets the <code>name</code> property to a string which is	 *  returned by the <code>createUniqueName()</code>	 *  method of the mx.utils.NameUtils class.</p>	 *	 *  <p>This string is the name of the object's class concatenated	 *  with an integer that is unique within the application,	 *  such as <code>"FlexShape15"</code>.</p>	 *	 *  @see flash.display.DisplayObject#name	 *  @see mx.utils.NameUtil#createUniqueName()
		 */
		public function FlexShape ();
		/**
		 *  Returns a string indicating the location of this object	 *  within the hierarchy of DisplayObjects in the Application.	 *  This string, such as <code>"MyApp0.HBox5.FlexShape15"</code>,	 *  is built by the <code>displayObjectToString()</code> method	 *  of the mx.utils.NameUtils class from the <code>name</code>	 *  property of the object and its ancestors.	 *  	 *  @return A String indicating the location of this object	 *  within the DisplayObject hierarchy. 	 *	 *  @see flash.display.DisplayObject#name	 *  @see mx.utils.NameUtil#displayObjectToString()
		 */
		public function toString () : String;
	}
}
