package mx.effects
{
	import mx.core.mx_internal;
	import mx.effects.effectClasses.CompositeEffectInstance;
	import mx.effects.effectClasses.PropertyChanges;

	[DefaultProperty("children")] 

include "../core/Version.as"
	/**
	 *  The CompositeEffect class is the parent class for the Parallel
 *  and Sequence classes, which define the <code>&lt;mx:Parallel&gt;</code>
 *  and <code>&lt;mx:Sequence&gt;</code> MXML tags.  
 *  Flex supports two methods to combine, or composite, effects:
 *  parallel and sequence.
 *  When you combine multiple effects in parallel,
 *  the effects play at the same time.
 *  When you combine multiple effects in sequence, 
 *  one effect must complete before the next effect starts.
 *
 *  <p>You can create a composite effect in MXML,
 *  as the following example shows:</p>
 *
 *  <pre>
 *  &lt;mx:Parallel id="WipeRightUp"&gt;
 *    &lt;mx:children&gt;
 *      &lt;mx:WipeRight duration="1000"/&gt;
 *      &lt;mx:WipeUp duration="1000"/&gt;
 *    &lt;/mx:children&gt;
 *  &lt;/mx:Parallel&gt;
 *   
 *  &lt;mx:VBox id="myBox" hideEffect="WipeRightUp"&gt;
 *    &lt;mx:TextArea id="aTextArea" text="hello"/&gt;
 *  &lt;/mx:VBox&gt;
 *  </pre>
 *
 *  <p>The <code>&lt;mx:children&gt;</code> tag is optional.</p>
 *  
 *  <p>Starting a composite effect in ActionScript is usually
 *  a five-step process:</p>
 *
 *  <ol>
 *    <li>Create instances of the effect objects to be composited together; 
 *    for example: 
 *    <pre>myFadeEffect = new mx.effects.Fade(target);</pre></li>
 *    <li>Set properties, such as <code>duration</code>,
 *    on the individual effect objects.</li>
 *    <li>Create an instance of the Parallel or Sequence effect object; 
 *    for example: 
 *    <pre>mySequenceEffect = new mx.effects.Sequence();</pre></li>
 *    <li>Call the <code>addChild()</code> method for each
 *    of the effect objects; for example: 
 *    <pre>mySequenceEffect.addChild(myFadeEffect);</pre></li>
 *    <li>Invoke the composite effect's <code>play()</code> method; 
 *    for example: 
 *    <pre>mySequenceEffect.play();</pre></li>
 *  </ol>
 *  
 *  @mxml
 *
 *  <p>The CompositeEffect class adds the following tag attributes,
 *  and all the subclasses of the CompositeEffect class
 *  inherit these tag attributes:</p>
 *  
 *  <pre>
 *  &lt;mx:<i>tagname</i>&gt;
 *    &lt;mx:children&gt;
 *      &lt;!-- Specify child effect tags --&gt; 
 *    &lt;/mx:children&gt;
 *  &lt;/mx:<i>tagname</i>&gt;
 *  </pre>
	 */
	public class CompositeEffect extends Effect
	{
		/**
		 *  @private
		 */
		private var childTargets : Array;
		/**
		 *  @private
		 */
		private var _affectedProperties : Array;
		/**
		 *  An Array containing the child effects of this CompositeEffect.
		 */
		public var children : Array;

		/**
		 *  Constructor. 
     * 
     *  @param target This argument is ignored for composite effects.
     *  It is included only for consistency with other types of effects.
		 */
		public function CompositeEffect (target:Object = null);

		/**
		 *  @private
		 */
		public function getAffectedProperties () : Array;

		/**
		 *  @private
		 */
		public function createInstance (target:Object = null) : IEffectInstance;

		/**
		 *  @private
		 */
		public function createInstances (targets:Array = null) : Array;

		/**
		 *  @private
		 */
		protected function filterInstance (propChanges:Array, targ:Object) : Boolean;

		/**
		 *  @private
		 */
		protected function initInstance (instance:IEffectInstance) : void;

		/**
		 *  @private
		 */
		public function captureStartValues () : void;

		/**
		 *  @private
		 */
		function captureValues (propChanges:Array, setStartValues:Boolean) : Array;

		/**
		 *  @private
		 */
		function applyStartValues (propChanges:Array, targets:Array) : void;

		/**
		 *  Adds a new child effect to this composite effect.
     *  A Sequence effect plays each child effect one at a time,
     *  in the order that they were added. 
     *  A Parallel effect plays all child effects simultaneously;
     *  the order in which they are added does not matter.
     *
     *  @param childEffect Child effect to be added
     *  to the composite effect.
		 */
		public function addChild (childEffect:IEffect) : void;

		/**
		 *  @private
     *  Figure out the targets of the children
		 */
		private function getChildrenTargets () : Array;
	}
}
