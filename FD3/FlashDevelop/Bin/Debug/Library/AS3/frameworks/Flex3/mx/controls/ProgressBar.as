/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.controls {
	import mx.core.UIComponent;
	import mx.core.IFontContextComponent;
	public class ProgressBar extends UIComponent implements IFontContextComponent {
		/**
		 * Number used to convert incoming current bytes loaded value and
		 *  the total bytes loaded values.
		 *  Flex divides the current and total values by this property and
		 *  uses the closest integer that is less than or equal to each
		 *  value in the label string. A value of 1 does no conversion.
		 */
		public function get conversion():Number;
		public function set conversion(value:Number):void;
		/**
		 * Direction in which the fill of the ProgressBar expands toward completion.
		 *  Valid values in MXML are
		 *  "right" and "left".
		 */
		public function get direction():String;
		public function set direction(value:String):void;
		/**
		 * Whether the ProgressBar control has a determinate or
		 *  indeterminate appearance.
		 *  Use an indeterminate appearance when the progress status cannot be determined.
		 *  If true, the appearance is indeterminate.
		 */
		public function get indeterminate():Boolean;
		public function set indeterminate(value:Boolean):void;
		/**
		 * Text that accompanies the progress bar. You can include
		 *  the following special characters in the text string:
		 *  %1 = current loaded bytes
		 *  %2 = total bytes
		 *  %3 = percent loaded
		 *  %% = "%" character
		 */
		public function get label():String;
		public function set label(value:String):void;
		/**
		 * Placement of the label.
		 *  Valid values in MXML are "right", "left",
		 *  "bottom", "center", and "top".
		 */
		public function get labelPlacement():String;
		public function set labelPlacement(value:String):void;
		/**
		 * Largest progress value for the ProgressBar. You
		 *  can only use this property in manual mode.
		 */
		public function get maximum():Number;
		public function set maximum(value:Number):void;
		/**
		 * Smallest progress value for the ProgressBar. This
		 *  property is set by the developer only in manual mode.
		 */
		public function get minimum():Number;
		public function set minimum(value:Number):void;
		/**
		 * Specifies the method used to update the bar.
		 *  Use one of the following values in MXML:
		 *  event The control specified by the source
		 *  property must dispatch progress and completed events.
		 *  The ProgressBar control uses these events to update its status.
		 *  The ProgressBar control only updates if the value of
		 *  the source property extends the EventDispatcher class.
		 *  polled The source property must specify
		 *  an object that exposes bytesLoaded and
		 *  bytesTotal properties. The ProgressBar control
		 *  calls these methods to update its status.
		 *  manual You manually update the ProgressBar status.
		 *  In this mode you specify the maximum and minimum
		 *  properties and use the setProgress() property method to
		 *  specify the status. This mode is often used when the indeterminate
		 *  property is true.
		 */
		public function get mode():String;
		public function set mode(value:String):void;
		/**
		 * Percentage of process that is completed.The range is 0 to 100.
		 *  Use the setProgress() method to change the percentage.
		 */
		public function get percentComplete():Number;
		/**
		 * Refers to the control that the ProgressBar is measuring the progress of. Use this property only in
		 *  event and polled mode. A typical usage is to set this property to a Loader control.
		 */
		public function get source():Object;
		public function set source(value:Object):void;
		/**
		 * Read-only property that contains the amount of progress
		 *  that has been made - between the minimum and maximum values.
		 */
		public function get value():Number;
		/**
		 * Constructor.
		 */
		public function ProgressBar();
		/**
		 * Sets the state of the bar to reflect the amount of progress made
		 *  when using manual mode.
		 *  The value argument is assigned to the value
		 *  property and the maximum argument is assigned to the
		 *  maximum property.
		 *  The minimum property is not altered.
		 *
		 * @param value             <Number> Current value.
		 * @param total             <Number> Total or target value.
		 */
		public function setProgress(value:Number, total:Number):void;
	}
}
