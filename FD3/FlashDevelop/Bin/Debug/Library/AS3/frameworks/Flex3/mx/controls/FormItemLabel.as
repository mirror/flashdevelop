﻿package mx.controls
{
include "../core/Version.as"
	/**
	 *  The FormItem container uses a FormItemLabel object to display the 
 *  label portion of the FormItem container.
 * 
 *  <p>The FormItemLabel class does not add any functionality to its superclass, Label. 
 *  Instead, its purpose is to let you set styles in a FormItemLabel type selector and 
 *  set styles that affect the labels in all FormItem containers.</p>
 * 
 *  <p><strong>Note:</strong> This class has been deprecated.  
 *  The recommended way to style a FormItem label is to use the 
 *  <code>labelStyleName</code> style property of the FormItem class.</p>
 *
 *  @see mx.containers.FormItem
	 */
	public class FormItemLabel extends Label
	{
		/**
		 *  Constructor.
		 */
		public function FormItemLabel ();
	}
}
