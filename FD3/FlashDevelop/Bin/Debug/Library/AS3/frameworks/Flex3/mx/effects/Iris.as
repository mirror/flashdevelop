package mx.effects
{
	import mx.effects.effectClasses.IrisInstance;

	/**
	 *  The Iris effect animates the effect target by expanding or contracting *  a rectangular mask centered on the target. *  The effect can either enlarge the mask from the center of the target *  to expose the target, or contract the mask toward the center *  to obscure the target. * *  @mxml * *  <p>The <code>&lt;mx:Iris&gt;</code> tag *  inherits all of the tag attributes of its superclass,  *  and adds the following tag attributes:</p> *   *  <pre> *  &lt;mx:Iris *    id="ID" *  /&gt; *  </pre> *   *  @see mx.effects.effectClasses.IrisInstance *  *  @includeExample examples/IrisEffectExample.mxml
	 */
	public class Iris extends MaskEffect
	{
		/**
		 *  Constructor.	 *	 *  @param target The Object to animate with this effect.
		 */
		public function Iris (target:Object = null);
	}
}
