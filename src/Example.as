/**
 * Tr.ace() Example Code by MSFX Matt Stuttard
 * Version 1.1 
 * 02.08.2011
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
	 * @author MSFX
	 */
	public class Example extends Sprite 
	{
		// dummy test class
		private var testClass:TestClass;
		
		
		/**
		 * Constructor
		 */
		public function Example():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		private function init(e:Event = null):void 
		{
			// remove listener
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/**
			 * There are several optional toggles you can use with Tr.ace, these are commented out below.
			 * You can combine options for example to only allow traces from 'MATT', within the Class 'AnotherTestClass', 
			 * formatted with linebreaks, timestamps and with the traces copied to the clipboard :)
			 */
			
			// uncomment to restrict the trace output from the 'Example' Class only
			//Tr.restrictToClasses = [Example];
			
			// uncomment to restrict the trace output from the 'Example' and 'AnotherTestClass' Classes only
			//Tr.restrictToClasses = [Example, AnotherTestClass];
			
			
			// uncomment to restrict the trace output from user 'MATT' only
			//Tr.restrictToUsers = [Tr.MATT];
			
			// uncomment to restrict the trace output from user 'MATT' AND 'DEFAULT' only
			//Tr.restrictToUsers = [Tr.MATT, Tr.DEFAULT];
			
			
			// uncomment to show the time with each trace
			//Tr.useTimeStamp = true;
			
			// uncomment to copy the trace output to the clipboard (non IDE debugging)
			//Tr.copyToClipboard = true;
			
			// uncomment to add linebreaks between each output
			//Tr.useLineBreaks = true;
			
			// uncomment to switch tracing off entirely
			//Tr.off = true;
			
			/**
			 * The following are several uses of Tr.ace(...) from several users.
			 * The instantiation of 'TestClass' will invoke Tr.ace(...) calls from within the TestClass
			 * and adding it to the stage will invoke further calls as well as the initialization of a 
			 * third class 'AnotherTestClass' which will make once last Tr.ace(...) call.
			 */
			
			// now lets add a trace statement from user 'MATT' within this 'Example' Class
			Tr.ace("Testing Tr.ace(...)!", Tr.MATT, Example);
			
			// we now initialize an instance of TestClass which triggers more trace statements
			testClass = new TestClass();
			
			// lets now trace from user 'DEFAULT' within this 'Example' Class
			Tr.ace("About to add TestClass to the stage.", Tr.DEFAULT, Example);
			
			// add the test class to the stage - triggers more traces
			addChild(testClass);
			
			// one final last trace from the user 'FLASH_DEVELOP'
			Tr.ace("This is the last Tr.ace(...) call (appears in red if using FlashDevelop!)", Tr.FLASH_DEVELOP, Example);
			
			
			/**
			 * The following demonstrates the use of Tr.aceArray(...) used for the tracing of Arrays.
			 * 
			 * First, uncomment line ~136 to demonstrate tracing a simple Array using Tr.aceArray(...).
			 * 
			 * Secondly, uncomment line ~143 to demonstrate tracing a more complex Array using Tr.aceArray(...).
			 * This more complex Array involves several nested Arrays and Objects.
			 * 
			 * You can also toggle whether line breaks appear between standard Tr.ace(...) calls and within the Tr.aceArray(...) 
			 * and Tr.aceObject(...) calls by toggling 'Tr.arrayAndObjectLinebreaks' on line ~130
			 */
			
			// set linebreaks on for Array and Object traces
			Tr.arrayAndObjectLinebreaks = true;
			
			// create an array of random elements
			var simpleArray:Array = ["simple", "array", "test", 101]; 
			
			// uncomment to trace the contents of the simpleArray using Tr.aceArray(...)
			// Tr.aceArray(simpleArray, Tr.MATT, Example);
			
			// create an array of random, more complex elements (nested arrays and objects)
			var complexArray:Array = ["aceArray(...)", "test", 101, 123.456, ["a", "nested", "array", "test!", ["a nested", "nested", "array!"]], true, {"a":1, "b":2}, "last element!"]; 
			
			// trace the contents of the Array using Tr.aceArray(...)
			// NB: the Object properties may not print out in the exact order they were entered due to the way they are internally stored
			//Tr.aceArray(complexArray, Tr.MATT, Example);
			
			
			
			/**
			 * The following demonstrates the use of Tr.aceObjects(...) used for the tracing of Objects
			 * 
			 * First, uncomment line ~165 to demonstrate tracing a simple Object using Tr.aceObject(...)
			 * 
			 * Secondly, uncomment line ~176 to demonstrate tracing a more complex Object using Tr.aceObject(...).
			 * This more complex Object involves several nested Arrays and Objects.
			 * 
			 * Again, you can also toggle whether line breaks appear between standard Tr.ace(...) calls and within 
			 * the Tr.aceArray(...) and Tr.aceObject(...) calls by toggling 'Tr.arrayAndObjectLinebreaks' on line ~130
			 */
			
			
			// create a simple object
			var simpleObject : Object = new Object();
			simpleObject.first = "simple";
			simpleObject.second = "stest";
			simpleObject.third = 101;
			
			// trace contents of the simpleObject using Tr.aceObject(...)
			// NB: they may not print out in the exact order they were entered due to the way they are internally stored
			//Tr.aceObject(simpleObject, Tr.MATT, Example);
			
			
			var complexObject:Object = new Object();
			complexObject.first = "start of the more complex test";
			complexObject.second = ["an array", "within", "an object!", ["with a", "nested array too!"]];
			complexObject.third = { "a": 1, "b" : 2, "c" : 3, "d" : 4, "e" : 5 };
			complexObject.fourth = "end of the more complex test";
			
			// trace contents of the simpleObject using Tr.aceObject(...)
			// NB: they may not print out in the exact order they were entered due to the way they are internally stored
			Tr.aceObject(complexObject, Tr.MATT, Example);
			
			
			var test:String = "multi test";
			var one:int = 1;
			var two:int = 2;
			var obj:Object = { };
			
			Tr.aceMulti(Tr.MATT, Example, test, one + two, ["a", "b", "c", "d"], obj);
		}
		
	}
}
