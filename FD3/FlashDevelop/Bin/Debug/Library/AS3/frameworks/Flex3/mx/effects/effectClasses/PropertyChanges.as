﻿package mx.effects.effectClasses
{
	import mx.core.IUIComponent;

include "../../core/Version.as"
	/**
	 *  The PropertyChanges class defines the start and end values
 *  for a set of properties of a target component of a transition.
 *  The <code>start</code> and <code>end</code> fields
 *  of the PropertyChanges class contain the same set of properties, 
 *  but with different values. 
 *
 *  <p>Target properties that have the same start and end values
 *  are not included in the <code>start</code> and <code>end</code> fields.</p>
 *
 *  @see mx.states.Transition
	 */
	public class PropertyChanges
	{
		/**
		 *  An Object containing the ending properties of the <code>target</code>
	 *  component modified by the change in view state.
	 *
	 *  <p>For example, for a <code>target</code> component that is both
	 *  moved and resized by a change to the view state, <code>end</code>
	 *  contains the ending position and size of the component, 
	 *  as the following example shows:
	 *  <pre>{ x: 100, y: 100, width: 200, height: 200 }</pre></p>
		 */
		public var end : Object;
		/**
		 *  An Object containing the starting properties of the <code>target</code>
	 *  component modified by the change in view state.
	 *
	 *  <p>For example, for a <code>target</code> component that is both
	 *  moved and resized by a change to the view state, <code>start</code>
	 *  contains the starting position and size of the component,
	 *  as the following example shows:
	 *  <pre>{ x: 0, y: 0, width: 100, height: 100}</pre></p>
		 */
		public var start : Object;
		/**
		 *  A target component of a transition.
	 *  The <code>start</code> and <code>end</code> fields
	 *  of the PropertyChanges object define how the target component
	 *  is modified by the change to the view state.
		 */
		public var target : Object;

		/**
		 *  The PropertyChanges constructor.
	 *
	 *  @param target Object that is a target of an effect.
		 */
		public function PropertyChanges (target:Object);
	}
}
