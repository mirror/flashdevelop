package mx.modules
{
	import flash.events.EventDispatcher;

include "../core/Version.as"
	/**
	 *  The base class for ActionScript-based dynamically-loadable modules.
 *  If you write an ActionScript-only module, you should extend this class.
 *  If you write an MXML-based module by using the <code>&lt;mx:Module&gt;</code> 
 *  tag in an MXML file, you instead extend the Module class.
 *  
 *  @see mx.modules.Module
	 */
	public class ModuleBase extends EventDispatcher
	{	}
}
