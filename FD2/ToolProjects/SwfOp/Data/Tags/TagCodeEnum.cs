/*
	swfOP is an open source library for manipulation and examination of
	Macromedia Flash (SWF) ActionScript bytecode.
	Copyright (C) 2004 Florian Krüsch.
	see Licence.cs for LGPL full text!

	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Lesser General Public
	License as published by the Free Software Foundation; either
	version 2.1 of the License, or (at your option) any later version.

	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	Lesser General Public License for more details.

	You should have received a copy of the GNU Lesser General Public
	License along with this library; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

namespace SwfOp.Data.Tags {

	// action tags:
	// 12: DoAction
	// 26: PlaceObject2
	// 39: DefineSprite
	// 59: InitAction

	// button tags, not implemented
	//  7: DefineButton
	// 34: DefineButton2

	/// <summary>
	/// enumeration of tag codes of tags containing bytecode.
	/// button tags are missing yet
	/// </summary>
	public enum TagCodeEnum {
		/// <summary>DefineBits tag</summary>
		DefineBits = 6,
		/// <summary>JPEGTable tag</summary>
		JpegTable = 8,
		/// <summary>DoAction tag</summary>
		DoAction = 12,
		/// <summary>DefineBitsJPEG2 tag</summary>
		DefineBitsJpeg2 = 21,
		/// <summary>PlaceObject2 tag</summary>
		PlaceObject2 = 26,
		/// <summary>DefineBitsJPEG3 tag</summary>
		DefineBitsJpeg3 = 35,
		/// <summary>DefineSprite tag</summary>
		DefineSprite = 39,
		/// <summary>NameCharacter tag</summary>
		NameCharacter = 40,
		/// <summary>Export tag</summary>
		Export = 56,
		/// <summary>InitAction tag</summary>
		InitAction = 59,
		/// <summary>ScriptLimit tag</summary>
		ScriptLimit = 65
	}
}
