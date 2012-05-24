/**
 * Tr.ace() Example Code by MSFX Matt Stuttard
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
package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import uk.msfx.utils.tracing.fp9.Tr;
	import uk.msfx.utils.tracing.users.TrUsers;
	
	
	/**
	 * A Test Class to demonstrate use of Tr.ace()
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class ExampleClass1_FP9 extends Sprite 
	{
		
		/**
		 * Constructor.
		 */
		public function ExampleClass1_FP9():void 
		{
			// create a trace from MSFX
			Tr.ace("Testing trace from ExampleClass1_FP9 Constructor", TrUsers.MSFX, Object(this).constructor);
			
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
			
			// once added to the stage, create another trace from MSFX
			Tr.ace("Added to stage", TrUsers.MSFX, Object(this).constructor);
			
			// instantiate another example class
			var exampleClass2:ExampleClass2_FP9 = new ExampleClass2_FP9();
		}
		
	}
}