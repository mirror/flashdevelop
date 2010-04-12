package org.flashdevelop.profiler 
{
	import flash.display.Sprite;
	import flash.sampler.clearSamples;
	import flash.sampler.DeleteObjectSample;
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
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author Philippe / http://philippe.elsass.me
	 */
	public class SampleRunner
	{
		private var refCache:Object = { };
		private var running:Boolean;
		private var ignoreTc:TypeContext = new TypeContext(null);
		
		public function SampleRunner() 
		{
			refCache[String] = ignoreTc;
			refCache[QName] = ignoreTc;
			
			startSampling();
			running = true;
		}
		
		public function cleanup():void
		{
			pause();
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
		
		public function outputReport(out:Array):void
		{
			for each(var tc:TypeContext in refCache)
			{
				var count:int = 0;
				var mem:int = 0;
				for each(var s:int in tc.obj) 
				{
					mem += s;
					count++;
				}
				
				if (count) 
				{
					if (tc.isNew)
					{
						tc.isNew = false;
						out.push(tc.index + "/" + count + "/" + mem + "/" + tc.name);
					}
					out.push(tc.index + "/" + count + "/" + mem);
				}
			}
		}
		
		public function liveObjectsCount():void
		{
			var samples:Object = getSamples();
			var type:String;
			var tc:TypeContext;
			var id:Number;
			
			for each(var sample:Object in samples) 
			{
				if (sample is NewObjectSample) 
				{
					var nos:NewObjectSample = NewObjectSample(sample);
					if (nos.object == undefined) 
						continue;
					
					id = nos.id;
					tc = refCache[nos.type];
					if (!tc) refCache[nos.type] = tc = new TypeContext(getQualifiedClassName(nos.type));
					else if (tc == ignoreTc) continue;
					tc.obj[nos.object] = getSize(nos.object);
				}
			}
			
			clearSamples();
		}
		
	}

}



import flash.utils.Dictionary;

class TypeContext
{
	static private var tcCount:int = 0;
	
	public var index:int = ++tcCount;
	public var isNew:Boolean = true;
	public var name:String;
	public var obj:Dictionary = new Dictionary(true);
	
	public function TypeContext(qname:String)
	{
		name = qname;
	}
}
