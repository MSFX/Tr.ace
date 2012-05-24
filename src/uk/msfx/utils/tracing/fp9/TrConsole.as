/**
 * Tr.ace() by MSFX Matt Stuttard Parker
 * Version 2.0
 * 24.05.2012
 * 
 * Copyright (c) MSFX Matt Stuttard Parker
 * 
 * http://msfx.co.uk
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
package uk.msfx.utils.tracing.fp9
{
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import uk.msfx.utils.tracing.core.TrConsoleCore;
	import uk.msfx.utils.tracing.fp9.Tr;
	
	/**
	 * Console for the Tr.ace() library (FP9 branch).
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class TrConsole extends TrConsoleCore 
	{
		/**
		 * Constructor for Tr.ace() Console
		 * 
		 * @param	width		The width of the console.
		 * @param	height		The height of the console.
		 */
		public function TrConsole(width:int = 600, height:int = 200) 
		{
			super(width, height, false);
		}
		
		/**
		 * Mouse Event Handler.
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
			}
		}
	}
}