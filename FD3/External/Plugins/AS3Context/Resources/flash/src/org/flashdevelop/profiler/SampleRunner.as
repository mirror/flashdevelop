package org.flashdevelop.profiler 
{
	import flash.display.Sprite;
	import flash.sampler.getSampleCount;
	import flash.sampler.getSamples;
	import flash.sampler.getSize;
	import flash.sampler.NewObjectSample;
	import flash.sampler.pauseSampling;
	import flash.sampler.startSampling;
	import flash.system.System;
	import flash.text.TextField;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class SampleRunner
	{
		private var newType:Object = { };
		private var typeSize:Object = { };
		private var inc:int = 1;
		private var typeCache:Dictionary = new Dictionary(true);
		private var refCache:Object = { };
		private var running:Boolean;
		
		public function SampleRunner() 
		{
			startSampling();
			running = true;
		}
		
		public function cleanup():void
		{
			pause();
			typeCache = null;
			refCache = null;
		}
		
		public function pause():void
		{
			if (!running) return;
			running = false;
			pauseSampling();
		}
		
		public function resume():void
		{
			if (running) return;
			running = true;
			startSampling();
		}
		
		public function liveObjectsCount(out:Array):void
		{
			countObjects();
			outputCount(out);
		}
		
		private function outputCount(out:Array):void
		{
			for (var type:String in refCache)
			{
				var list:Dictionary = refCache[type];
				
				var count:int = 0;
				var mem:int = 0;
				for (var o:Object in list) 
				{
					mem += getSize(o);
					count++;
				}
					
				if (count) 
				{
					var index:int = newType[type];
					if (!index)
					{
						newType[type] = index = inc++;
						out.push(index + "/" + count + "/" + mem + "/" + type);
					}
					out.push(index + "/" + count + "/" + mem);
				}
			}
		}
		
		private function countObjects():void
		{
			var samples:Object = getSamples();
			
			for each(var sample:Object in samples) 
			{
				if (sample is NewObjectSample) 
				{
					var nos:NewObjectSample = NewObjectSample(sample);
					if (nos.object is String) continue;
					
					var type:String = typeCache[nos.type];
					if (type == null) 
					{
						typeCache[nos.type] = type = describeType(nos.type).@name;
						typeSize[type] = getSize(nos.object);
					}
					
					if (nos.object != undefined) 
					{
						if (!(refCache[type] is Dictionary))
							refCache[type] = new Dictionary(true);
						refCache[type][nos.object] = true;
					}
				}
			}
		}
		
	}

}