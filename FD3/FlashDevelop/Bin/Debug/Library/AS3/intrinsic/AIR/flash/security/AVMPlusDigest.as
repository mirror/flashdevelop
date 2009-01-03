package flash.security
{
	import flash.utils.IDataInput;

	public class AVMPlusDigest extends Object
	{
		public function FinishDigest (inDigestToCompare:String) : uint;

		public function Init (algorithm:uint) : void;

		public function Update (data:IDataInput) : uint;

		public function UpdateWithString (data:String) : uint;
	}
}
