/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.automation.delegates {
	import flash.events.IEventDispatcher;
	import mx.automation.IAutomationObject;
	import mx.core.IUITextField;
	import flash.events.Event;
	public class TextFieldAutomationHelper {
		/**
		 * Constructor.
		 *
		 * @param owner             <IEventDispatcher> 
		 * @param replayer          <IAutomationObject> 
		 * @param textField         <IUITextField> 
		 */
		public function TextFieldAutomationHelper(owner:IEventDispatcher, replayer:IAutomationObject, textField:IUITextField);
		/**
		 * Records the user interaction with the text control.
		 *
		 * @param interaction       <Event> 
		 * @param cacheable         <Boolean (default = false)> 
		 */
		public function recordAutomatableEvent(interaction:Event, cacheable:Boolean = false):void;
		/**
		 * Replays TypeTextEvents and TypeEvents. TypeTextEvents are replayed by
		 *  calling replaceText on the underlying text field. TypeEvents are replayed
		 *  depending on the character typed.  Both also dispatch the origin keystrokes.
		 *  This is necessary to mimic the original behavior, in case any components are
		 *  listening to keystroke events (for example, DataGrid listens to itemRenderer events,
		 *  or if a custom component is trying to do key masking).  Ideally, the code would just
		 *  dispatch the original keystrokes, but the Flash Player TextField ignores
		 *  the events we are sending it.
		 *
		 * @param event             <Event> Event to replay.
		 * @return                  <Boolean> If true, replay the event.
		 */
		public function replayAutomatableEvent(event:Event):Boolean;
	}
}
