package flash.text.engine
{
	/// The EastAsianJustifier class has properties to control the justification options for text lines whose content is primarily East Asian text.
	public class EastAsianJustifier extends flash.text.engine.TextJustifier
	{
		/// Specifies the justification style for the text in a text block.
		public var justificationStyle:String;

		/// [FP10] Creates a EastAsianJustifier object.
		public function EastAsianJustifier(locale:String=ja, lineJustification:String=allButLast, justificationStyle:String=pushInKinsoku);

		/// [FP10] Constructs a cloned copy of the EastAsianJustifier.
		public function clone():flash.text.engine.TextJustifier;

	}

}

