/**
 * Tr.ace() Example Code by MSFX Matt Stuttard
 * Version 1.0 
 * 29.07.2011
 * 
 * Copyright (c) MSFX Matt Stuttard
 * 
 * http://msfx.co.uk
 * http://labs.msfx.co.uk
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
package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import uk.msfx.utils.tracing.Tr;
	
	
	/**
	 * Test Class to demonstrate use of Tr.ace()
	 * @author MSFX
	 */
	public class TestClass extends Sprite 
	{
		
		/**
		 * Constructor.
		 */
		public function TestClass():void 
		{
			// create a trace from MATT
			Tr.ace("testing trace from constructor", Tr.MATT, TestClass);
			
			// add event listener for adding to stage
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		
		/**
		 * Added to Stage Event Handler
		 * @param	e Event
		 */
		private function added(e:Event):void 
		{
			// remove listener
			removeEventListener(Event.ADDED_TO_STAGE, added);
			
			// once added to the stage, create another trace from MATT
			Tr.ace("added to stage", Tr.MATT, TestClass);
			
			// instantiate another test class
			var anotherTestClass:AnotherTestClass = new AnotherTestClass();
		}
		
	}
}