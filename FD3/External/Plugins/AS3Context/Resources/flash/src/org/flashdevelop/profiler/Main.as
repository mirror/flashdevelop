package org.flashdevelop.profiler
{
	import flash.display.LoaderInfo;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	import flash.xml.XMLNode;
	import org.flashdevelop.utils.FlashConnect;
	
	/**
	 * ...
	 * @author Philippe
	 */
	public class Main extends Sprite 
	{
		private var ready:int = 0;
		private var target:String;
		private var sampler:SampleRunner;
		private var update:Timer;
		private var id:int;
		private var tempo:int;
		
		/* SETUP */
		
		public function Main():void 
		{
			addEventListener("allComplete", loadComplete);
			
			if (FlashConnect.initialize()) ++ready;
			else FlashConnect.onConnection = onConnection;
			
			sampler = new SampleRunner();
		}
		
		private function onConnection():void
		{
			configure();
		}
		
		private function loadComplete(e:Event):void 
		{
			removeEventListener("allComplete", loadComplete);
			
			var info:LoaderInfo = e.target as LoaderInfo;
			target = info.url;
			
			configure();
		}
		
		private function configure():void
		{
			if (++ready < 2) return;
			
			sampler.pause();
			
			FlashConnect.trace("[Profiling: " + target + "]");
			FlashConnect.flush();
			
			id = getTimer();
			FlashConnect.onReturnData = onReturn;
			
			update = new Timer(100);
			update.addEventListener(TimerEvent.TIMER, update_timer);
			update.start();
			
			sampler.resume();
		}
		
		
		/* PROFILING */
		
		private function onReturn(status:String):void
		{
			sampler.pause();
			
			var res:XML = XML(status);
			if (res.@status == "1") // invalid: stop profiling
			{
				update.stop();
				FlashConnect.onReturnData = null;
				sampler.cleanup();
			}
			else if (res.@status == "4") // run GC
			{
				FlashConnect.trace("[GC]");
				FlashConnect.flush();
				System.gc();
			}
			
			sampler.resume();
		}
		
		private function update_timer(e:TimerEvent):void 
		{
			sampler.pause();
			
			sampler.liveObjectsCount();
			
			if (++tempo > 10) 
			{
				tempo = 0;
				
				var out:Array = [ id + "/" + System.totalMemory ];
				sampler.outputReport(out);
				
				var msgNode:XMLNode = new XMLNode(1, null);
				msgNode.attributes.guid = "ccf2c534-db6b-4c58-b90e-cd0b837e61c4";
				msgNode.attributes.cmd = "notify";
				msgNode.nodeName = "message";
				msgNode.appendChild( new XMLNode(3, out.join("|") ));
				
				FlashConnect.send(msgNode);
				FlashConnect.flush();
				var n:String = msgNode.toString();
			}
			
			sampler.resume();
		}
		
	}
	
}