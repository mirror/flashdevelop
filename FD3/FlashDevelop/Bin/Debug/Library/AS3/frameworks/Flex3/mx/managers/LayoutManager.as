﻿package mx.managers
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import mx.core.ApplicationGlobals;
	import mx.core.IFlexDisplayObject;
	import mx.core.mx_internal;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.managers.layoutClasses.PriorityQueue;

include "../core/Version.as"
	/**
	 *  The LayoutManager is the engine behind
 *  Flex's measurement and layout strategy.
 *  Layout is performed in three phases; commit, measurement, and layout.
 *
 *  <p>Each phase is distinct from the others and all UIComponents of
 *  one phase are processed prior to moving on to the next phase.
 *  During the processing of UIComponents in a phase, requests for
 *  UIComponents to get re-processed by some phase may occur.
 *  These requests are queued and are only processed
 *  during the next run of the phase.</p>
 *
 *  <p>The <b>commit</b> phase begins with a call to
 *  <code>validateProperties()</code>, which walks through a list
 *  (reverse sorted by nesting level) of objects calling each object's
 *  <a href="../core/UIComponent.html#validateProperties()">
 *  <code>validateProperties()</code></a>method.</p>
 *
 *  <p>The objects in the list are processed in reversed nesting order,
 *  with the <b>least</b> deeply nested object accessed first.
 *  This can also be referred to as top-down or outside-in ordering.</p>
 *
 *  <p>This phase allows components whose contents depend on property
 *  settings to configure themselves prior to the measurement
 *  and the layout phases.
 *  For the sake of performance, sometimes a component's property setter
 *  method does not do all the work to update to the new property value.
 *  Instead, the property setter calls the <code>invalidateProperties()</code>
 *  method, deferring the work until this phase runs.
 *  This prevents unnecessary work if the property is set multiple times.</p>
 *
 *  <p>The <b>measurement</b> phase begins with a call to
 *  <code>validateSize()</code>, which walks through a list
 *  (sorted by nesting level) of objects calling each object's
 *  <a href="../core/UIComponent.html#validateSize()"><code>validateSize()</code></a>
 *  method to determine if the object has changed in size.</p>
 *
 *  <p>If an object's <a href="../core/UIComponent.html#invalidateSize()">
 *  <code>invalidateSize()</code></a> method was previously called,
 *  then the <code>validateSize()</code> method is called.
 *  If the size or position of the object was changed as a result of the
 *  <code>validateSize()</code> call, then the object's
 *  <a href="../core/UIComponent.html#invalidateDisplayList()">
 *  <code>invalidateDisplayList()</code></a> method is called, thus adding
 *  the object to the processing queue for the next run of the layout phase.
 *  Additionally, the object's parent is marked for both measurement
 *  and layout phases, by calling
 *  <a href="../core/UIComponent.html#invalidateSize()">
 *  <code>invalidateSize()</code></a> and
 *  <a href="../core/UIComponent.html#invalidateDisplayList()">
 *  <code>invalidateDisplayList()</code></a> respectively.</p>
 *
 *  <p>The objects in the list are processed by nesting order,
 *  with the <b>most</b> deeply nested object accessed first.
 *  This can also be referred to as bottom-up inside-out ordering.</p>
 *
 *  <p>The <b>layout</b> phase begins with a call to the 
 *  <code>validateDisplayList()</code> method, which walks through a list
 *  (reverse sorted by nesting level) of objects calling each object's
 *  <a href="../core/UIComponent.html#validateDisplayList()">
 *  <code>validateDisplayList()</code></a> method to request the object to size
 *  and position all components contained within it (i.e. its children).</p>
 *
 *  <p>If an object's <a href="../core/UIComponent.html#invalidateDisplayList()">
 *  <code>invalidateDisplayList()</code></a> method was previously called,
 *  then <code>validateDisplayList()</code> method for the object is called.</p>
 *
 *  <p>The objects in the list are processed in reversed nesting order,
 *  with the <b>least</b> deeply nested object accessed first.
 *  This can also be referred to as top-down or outside-in ordering.</p>
 *
 *  <p>In general, components do not override the <code>validateProperties()</code>, 
 *  <code>validateSize()</code>, or <code>validateDisplayList()</code> methods.  
 *  In the case of UIComponents, most components override the 
 *  <code>co
	 */
	public class LayoutManager extends EventDispatcher implements ILayoutManager
	{
		/**
		 *  @private
	 *  The sole instance of this singleton class.
		 */
		private static var instance : LayoutManager;
		/**
		 *  @private
	 *  A queue of objects that need to dispatch updateComplete events
	 *  when invalidation processing is complete
		 */
		private var updateCompleteQueue : PriorityQueue;
		/**
		 *  @private
	 *  A queue of objects to be processed during the first phase
	 *  of invalidation processing, when an ILayoutManagerClient  has
	 *  its validateProperties() method called (which in a UIComponent
	 *  calls commitProperties()).
	 *  Objects are added to this queue by invalidateProperties()
	 *  and removed by validateProperties().
		 */
		private var invalidatePropertiesQueue : PriorityQueue;
		/**
		 *  @private
	 *  A flag indicating whether there are objects
	 *  in the invalidatePropertiesQueue.
	 *  It is set true by invalidateProperties()
	 *  and set false by validateProperties().
		 */
		private var invalidatePropertiesFlag : Boolean;
		private var invalidateClientPropertiesFlag : Boolean;
		/**
		 *  @private
	 *  A queue of objects to be processed during the second phase
	 *  of invalidation processing, when an ILayoutManagerClient  has
	 *  its validateSize() method called (which in a UIComponent
	 *  calls measure()).
	 *  Objects are added to this queue by invalidateSize().
	 *  and removed by validateSize().
		 */
		private var invalidateSizeQueue : PriorityQueue;
		/**
		 *  @private
	 *  A flag indicating whether there are objects
	 *  in the invalidateSizeQueue.
	 *  It is set true by invalidateSize()
	 *  and set false by validateSize().
		 */
		private var invalidateSizeFlag : Boolean;
		private var invalidateClientSizeFlag : Boolean;
		/**
		 *  @private
	 *  A queue of objects to be processed during the third phase
	 *  of invalidation processing, when an ILayoutManagerClient  has
	 *  its validateDisplayList() method called (which in a
	 *  UIComponent calls updateDisplayList()).
	 *  Objects are added to this queue by invalidateDisplayList()
	 *  and removed by validateDisplayList().
		 */
		private var invalidateDisplayListQueue : PriorityQueue;
		/**
		 *  @private
	 *  A flag indicating whether there are objects
	 *  in the invalidateDisplayListQueue.
	 *  It is set true by invalidateDisplayList()
	 *  and set false by validateDisplayList().
		 */
		private var invalidateDisplayListFlag : Boolean;
		/**
		 *  @private
		 */
		private var callLaterObject : UIComponent;
		/**
		 *  @private
		 */
		private var callLaterPending : Boolean;
		/**
		 *  @private
		 */
		private var originalFrameRate : Number;
		/**
		 *  @private
	 *  used in validateClient to quickly estimate whether we have to
	 *  search the queues again
		 */
		private var targetLevel : int;
		/**
		 *  @private
	 *  Storage for the usePhasedInstantiation property.
		 */
		private var _usePhasedInstantiation : Boolean;

		/**
		 *  A flag that indicates whether the LayoutManager allows screen updates
	 *  between phases.
	 *  If <code>true</code>, measurement and layout are done in phases, one phase
	 *  per screen update.
	 *  All components have their <code>validateProperties()</code> 
	 *  and <code>commitProperties()</code> methods 
	 *  called until all their properties are validated.  
	 *  The screen will then be updated.  
	 * 
	 *  <p>Then all components will have their <code>validateSize()</code> 
	 *  and <code>measure()</code>
	 *  methods called until all components have been measured, then the screen
	 *  will be updated again.  </p>
	 *
	 *  <p>Finally, all components will have their
	 *  <code>validateDisplayList()</code> and 
	 *  <code>updateDisplayList()</code> methods called until all components
	 *  have been validated, and the screen will be updated again.  
	 *  If in the validation of one phase, an earlier phase gets invalidated, 
	 *  the LayoutManager starts over.  
	 *  This is more efficient when large numbers of components
	 *  are being created an initialized.  The framework is responsible for setting
	 *  this property.</p>
	 *
	 *  <p>If <code>false</code>, all three phases are completed before the screen is updated.</p>
		 */
		public function get usePhasedInstantiation () : Boolean;
		/**
		 *  @private
		 */
		public function set usePhasedInstantiation (value:Boolean) : void;

		/**
		 *  Returns the sole instance of this singleton class,
	 *  creating it if it does not already exist.
         *
         *  @return Returns the sole instance of this singleton class,
	 *  creating it if it does not already exist.
		 */
		public static function getInstance () : LayoutManager;

		/**
		 *  Constructor.
		 */
		public function LayoutManager ();

		/**
		 *  Adds an object to the list of components that want their 
	 *  <code>validateProperties()</code> method called.
	 *  A component should call this method when a property changes.  
	 *  Typically, a property setter method
	 *  stores a the new value in a temporary variable and calls 
	 *  the <code>invalidateProperties()</code> method 
	 *  so that its <code>validateProperties()</code> 
	 *  and <code>commitProperties()</code> methods are called
	 *  later, when the new value will actually be applied to the component and/or
	 *  its children.  The advantage of this strategy is that often, more than one
	 *  property is changed at a time and the properties may interact with each
	 *  other, or repeat some code as they are applied, or need to be applied in
	 *  a specific order.  This strategy allows the most efficient method of
	 *  applying new property values.
	 *
	 *  @param obj The object whose property changed.
		 */
		public function invalidateProperties (obj:ILayoutManagerClient) : void;

		/**
		 *  Adds an object to the list of components that want their 
	 *  <code>validateSize()</code> method called.
	 *  Called when an object's size changes.
	 *
	 *  <p>An object's size can change for two reasons:</p>
	 *
	 *  <ol>
	 *    <li>The content of the object changes. For example, the size of a
	 *    button changes when its <code>label</code> is changed.</li>
	 *    <li>A script explicitly changes one of the following properties:
	 *    <code>minWidth</code>, <code>minHeight</code>,
	 *    <code>explicitWidth</code>, <code>explicitHeight</code>,
	 *    <code>maxWidth</code>, or <code>maxHeight</code>.</li>
	 *  </ol>
	 *
	 *  <p>When the first condition occurs, it's necessary to recalculate
	 *  the measurements for the object.
	 *  When the second occurs, it's not necessary to recalculate the
	 *  measurements because the new size of the object is known.
	 *  However, it's necessary to remeasure and relayout the object's
	 *  parent.</p>
	 *
	 *  @param obj The object whose size changed.
		 */
		public function invalidateSize (obj:ILayoutManagerClient) : void;

		/**
		 *  Called when a component changes in some way that its layout and/or visuals
	 *  need to be changed.
	 *  In that case, it is necessary to run the component's layout algorithm,
	 *  even if the component's size hasn't changed.  For example, when a new child component
	 *  is added, or a style property changes or the component has been given
	 *  a new size by its parent.
	 *
	 *  @param obj The object that changed.
		 */
		public function invalidateDisplayList (obj:ILayoutManagerClient) : void;

		/**
		 *  Validates all components whose properties have changed and have called
	 *  the <code>invalidateProperties()</code> method.  
	 *  It calls the <code>validateProperties()</code> method on those components
	 *  and will call <code>validateProperties()</code> on any other components that are 
	 *  invalidated while validating other components.
		 */
		private function validateProperties () : void;

		/**
		 *  Validates all components whose properties have changed and have called
	 *  the <code>invalidateSize()</code> method.  
	 *  It calls the <code>validateSize()</code> method on those components
	 *  and will call the <code>validateSize()</code> method 
	 *  on any other components that are 
	 *  invalidated while validating other components.  
	 *  The </code>validateSize()</code> method  starts with
	 *  the most deeply nested child in the tree of display objects
		 */
		private function validateSize () : void;

		/**
		 *  Validates all components whose properties have changed and have called
	 *  the <code>invalidateDisplayList()</code> method.  
	 *  It calls <code>validateDisplayList()</code> method on those components
	 *  and will call the <code>validateDisplayList()</code> method 
	 *  on any other components that are 
	 *  invalidated while validating other components.  
	 *  The <code>validateDisplayList()</code> method starts with
	 *  the least deeply nested child in the tree of display objects
	 *
		 */
		private function validateDisplayList () : void;

		/**
		 *  @private
		 */
		private function doPhasedInstantiation () : void;

		/**
		 *  When properties are changed, components generally do not apply those changes immediately.
	 *  Instead the components usually call one of the LayoutManager's invalidate methods and
	 *  apply the properties at a later time.  The actual property you set can be read back
	 *  immediately, but if the property affects other properties in the component or its
	 *  children or parents, those other properties may not be immediately updated.  To
	 *  guarantee that the values are updated, you can call the <code>validateNow()</code> method.  
	 *  It updates all properties in all components before returning.  
	 *  Call this method only when necessary as it is a computationally intensive call.
		 */
		public function validateNow () : void;

		/**
		 *  When properties are changed, components generally do not apply those changes immediately.
	 *  Instead the components usually call one of the LayoutManager's invalidate methods and
	 *  apply the properties at a later time.  The actual property you set can be read back
	 *  immediately, but if the property affects other properties in the component or its
	 *  children or parents, those other properties may not be immediately updated.  
	 *
	 *  <p>To guarantee that the values are updated, 
	 *  you can call the <code>validateClient()</code> method.  
	 *  It updates all properties in all components whose nest level is greater than or equal
	 *  to the target component before returning.  
	 *  Call this method only when necessary as it is a computationally intensive call.</p>
	 *
	 *  @param target The component passed in is used to test which components
	 *  should be validated.  All components contained by this component will have their
	 *  <code>validateProperties()</code>, <code>commitProperties()</code>, 
	 *  <code>validateSize()</code>, <code>measure()</code>, 
	 *  <code>validateDisplayList()</code>, 
	 *  and <code>updateDisplayList()</code> methods called.
	 *
	 *	@param skipDisplayList If <code>true</code>, 
	 *  does not call the <code>validateDisplayList()</code> 
	 *  and <code>updateDisplayList()</code> methods.
		 */
		public function validateClient (target:ILayoutManagerClient, skipDisplayList:Boolean = false) : void;

		/**
		 *  Returns <code>true</code> if there are components that need validating;
	 *  <code>false</code> if all components have been validated.
         *
         *  @return Returns <code>true</code> if there are components that need validating;
	 *  <code>false</code> if all components have been validated.
		 */
		public function isInvalid () : Boolean;

		/**
		 *  @private
	 *  callLater() is called immediately after an object is created.
	 *  We really want to wait one more frame before starting in.
		 */
		private function waitAFrame () : void;
	}
}
