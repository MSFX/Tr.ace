/**
 * Tr.ace() by MSFX Matt Stuttard Parker
 * Version 2.0
 * 10.06.2012
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
package uk.msfx.utils.tracing.core
{
	import flash.events.Event;
	import flash.text.TextField;
	
	/**
	 * Custom TextField for Tr.ace() Console.
	 * 
	 * <p>Dispatches Event.CHANGE every time appendText(...) is called.</p>
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class TrTextField extends TextField 
	{
		
		/**
		 * Constructor.
		 */
		public function TrTextField():void {	}
		
		
		/**
		 * Dispatch Change Event when text is appended.
		 * 
		 * @param	newText	
		 */
		override public function appendText(newText:String):void 
		{
			super.appendText(newText);
			
			// dispatch change event
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
	}
}