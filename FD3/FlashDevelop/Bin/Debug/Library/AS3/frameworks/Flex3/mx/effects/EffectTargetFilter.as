/**********************************************************/
/*** Generated using Asapire [brainy 2008-Mar-07 11:06] ***/
/**********************************************************/
package mx.effects {
	public class EffectTargetFilter {
		/**
		 * A function that defines custom filter logic.
		 *  Flex calls this method on every target of the effect.
		 *  If the function returns true,
		 *  the effect plays on the target;
		 *  if it returns false, the target is skipped by the effect.
		 *  A custom filter function gives you greater control over filtering
		 *  than the Effect.filter property.
		 */
		public var filterFunction:Function;
		/**
		 * An Array of Strings specifying component properties.
		 *  If any of the properties in the Array changed on the target component,
		 *  play the effect on the target.
		 */
		public var filterProperties:Array;
		/**
		 * An Array of Strings specifying style properties.
		 *  If any of the style properties in the Array changed on the target component,
		 *  play the effect on the target.
		 */
		public var filterStyles:Array;
		/**
		 * A collection of properties and associated values which must be associated
		 *  with a target for the effect to be played.
		 */
		public var requiredSemantics:Object = null;
		/**
		 * Constructor.
		 */
		public function EffectTargetFilter();
		/**
		 * The default filter function for the EffectTargetFilter class.
		 *  If the instanceTarget has different start and end values
		 *  for any of the values specified by the filterProperties
		 *  or filterStyles properties, play the effect on the target.
		 *
		 * @param propChanges       <Array> An Array of PropertyChanges objects.
		 *                            The target property of each PropertyChanges object
		 *                            is equal to the effect's target.
		 *                            If no properties changed for an effect target,
		 *                            it is not included in this Array.
		 * @param instanceTarget    <Object> The target of the EffectInstance
		 *                            that calls this function.
		 *                            If an effect has multiple targets,
		 *                            this function is called once per target.
		 * @return                  <Boolean> Returns true to allow the effect instance to play.
		 */
		protected function defaultFilterFunction(propChanges:Array, instanceTarget:Object):Boolean;
		/**
		 * Determines whether a target should be filtered, returning true if it should be
		 *  included in an effect.
		 *  The determination is made by calling filterFunction and semanticFilterFunction,
		 *  returning true if and only if both functions return true. The default functions
		 *  with the default values will always return true.
		 *  Typically, an EffectTargetFilter will use one type of filter or the other, but
		 *  not both.
		 *
		 * @param propChanges       <Array> 
		 * @param semanticsProvider <IEffectTargetHost> 
		 * @param target            <Object> 
		 */
		public function filterInstance(propChanges:Array, semanticsProvider:IEffectTargetHost, target:Object):Boolean;
	}
}
