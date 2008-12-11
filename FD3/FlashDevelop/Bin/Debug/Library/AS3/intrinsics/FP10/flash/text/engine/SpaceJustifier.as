package flash.text.engine
{
	/// The SpaceJustifier class represents properties that control the justification options for text lines in a text block.
	public class SpaceJustifier extends flash.text.engine.TextJustifier
	{
		/// Specifies whether to use letter spacing during justification.
		public var letterSpacing:Boolean;

		/// [FP10] Creates a SpaceJustifier object.
		public function SpaceJustifier(locale:String=en, lineJustification:String=unjustified, letterSpacing:Boolean=false);

		/// [FP10] Constructs a cloned copy of the SpaceJustifier.
		public function clone():flash.text.engine.TextJustifier;

	}

}

