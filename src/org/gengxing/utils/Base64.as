package org.gengxing.utils
{
	import flash.utils.ByteArray;
	
	/**
	 * base64
	 * http://www.gengxing.org
	 * @author gengxing
	 * 2013-12-17 16:29
	 * License: MIT
	 */
	public class Base64
	{
		private static const _chars:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
		
		public static function encode(data:ByteArray):String {
			var str:String = "";
			var len:int = data.length;
			for (var i:int = 0; i < len; i += 3) {
				str += _chars.charAt((data[i] >> 2) & 0x3F);
				str += _chars.charAt(((data[i] & 0x3) << 4) | (data[i + 1] >> 4));
				str += _chars.charAt(((data[i + 1] & 0xF) << 2) | (data[i + 2] >> 6));
				str += _chars.charAt(data[i + 2] & 0x3F);
			}
			var num:int = 3 - (len % 3);
			if (num == 2) str += "==";
			if (num == 1) str += "=";
			return str;
		}
		
		public static function encodeStr(str:String):String {
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes(str);
			
			return encode(bytes);
		}
		
		public static function decode(str:String):ByteArray {
			str = str.replace(/\n/g, '');
			var result:ByteArray = new ByteArray();
			
			var code:int = 0;
			var len:int = str.length;
			for (var i:int = 0; i < len; i += 4) {
				code = (_chars.indexOf(str.charAt(i)) & 0x3F) << 18;
				code += (_chars.indexOf(str.charAt(i + 1)) & 0x3F) << 12;
				code += (_chars.indexOf(str.charAt(i + 2)) & 0x3F) << 6;
				code += (_chars.indexOf(str.charAt(i + 3)) & 0x3F);
				
				result.writeByte(code >> 16 & 0xFF);
				result.writeByte(code >> 8 & 0xFF);
				result.writeByte(code & 0xFF);
			}
			
			if (code & 0x3F == 0) result.length -= 1; 
			if (code >> 8 & 0x3F == 0) result.length -= 1; 
			result.position = 0;
			
			return result;
		}
	}
}