package mx.effects
{
	import mx.effects.effectClasses.PauseInstance;

include "../core/Version.as"
	/**
	 *  The Pause effect is useful when sequencing effects.
 *  It does nothing for a specified period of time.
 *  If you add a Pause effect as a child of a Sequence effect,
 *  you can create a pause between the two other effects.
 *  
 *  @mxml
 *
 *  <p>The <code>&lt;mx:Pause&gt;</code> tag
 *  inherits all the tag attributes of its superclass, 
 *  and adds the following tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:Pause 
 *    id="ID" 
 *  /&gt;
 *  </pre>
 *  
 *  @see mx.effects.effectClasses.PauseInstance
 *
 *  @includeExample examples/PauseEffectExample.mxml
	 */
	public class Pause extends TweenEffect
	{
		/**
		 *  Constructor.
	 *
	 *  @param target This argument is ignored by the Pause effect.
	 *  It is included for consistency with other effects.
		 */
		public function Pause (target:Object = null);

		/**
		 *  @private
		 */
		public function createInstances (targets:Array = null) : Array;
	}
}
