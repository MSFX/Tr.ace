/**
 * Tr.ace() by MSFX Matt Stuttard Parker
 * Version 2.0
 * 10.06.2012
 * 
 * Copyright (c) MSFX Matt Stuttard Parker
 * 
 * http://msfx.co.uk
 * 
 * Thanks to @MichaelJW for ideas and testing with TrConsole.
 * 
 * 
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 **/
package uk.msfx.utils.tracing.fp10
{
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import uk.msfx.utils.tracing.core.TrConsoleCore;
	import uk.msfx.utils.tracing.fp10.Tr;
	
	
	/**
	 * Console for the Tr.ace() library (FP10 Branch).
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class TrConsole extends TrConsoleCore 
	{
		/**
		 * Constructor for Tr.ace() Console.
		 * 
		 * @param	width					The width of the console.
		 * @param	height					The height of the console.
		 * @param	transparentOnHide		OPTIONAL Whether to make the console transparent when minimizing.
		 */
		public function TrConsole(width:int = 600, height:int = 200, transparentOnHide:Boolean = false) 
		{
			super(width, height, true, transparentOnHide);
			
			// connect to the Tr.ace() library to save assigning manually
			Tr.console = _textfield;
		}
		
		/**
		 * Mouse Event Handler.
		 * @private
		 * 
		 * @param	e	MouseEvent.CLICK
		 */
		override protected function mouseEventHandler(e:MouseEvent):void 
		{
			super.mouseEventHandler(e);
			
			switch (e.currentTarget.name) 
			{
				case "clearButton":
					Tr.clearLog();
				break;
				
				case "clipboardButton":
					Tr.copyLogToClipboard();
				break;
				
				case "saveButton":
					Tr.saveLog();
				break;
			}
		}
	}
}