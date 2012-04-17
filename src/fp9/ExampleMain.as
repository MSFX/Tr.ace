/**
 * Tr.ace() Example Code by MSFX Matt Stuttard
 * Version 1.6
 * 17.04.2012
 * 
 * Copyright (c) MSFX Matt Stuttard Parker
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
	import flash.text.TextField;
	import uk.msfx.utils.tracing.fp9.Tr;
	import uk.msfx.utils.tracing.users.TrUsers;
	
	/**
	 * This is an Example Class for demonstrating Tr.ace().  
	 * 
	 * You can publish this Class on its own or via the ExampleMain_CS3 FLA included.
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class ExampleMain extends Sprite 
	{
		// dummy test class
		private var exampleClass:ExampleClass1_FP9;
		
		
		/**
		 * Constructor.
		 */
		public function ExampleMain():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		/**
		 * Event Handler to initialize the Application.
		 * 
		 * @param	e Event.ADDED_TO_STAGE
		 */
		private function init(e:Event = null):void 
		{
			// remove event listener
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/**
			 * Welcome to the Tr.ace() Example!
			 * 
			 * There are several optional toggles you can use with the Tr.ace library, these are commented out below.
			 * 
			 * You can combine options for example to only allow traces from 'MSFX', within the Class 'AnotherTestClass', 
			 * formatted with linebreaks and timestamps :)
			 */
			
			// uncomment to restrict the trace output(s) to only the 'ExampleClass2_FP9' Class
			//Tr.restrictToClasses = [ExampleClass2_FP9];
			
			// uncomment to restrict the trace output(s) to only the 'ExampleMain' and 'ExampleClass2_FP9' Classes
			//Tr.restrictToClasses = [ExampleMain, ExampleClass2_FP9];
			
			// uncomment to ignore the trace output(s) from the 'ExampleMain' Class only
			//Tr.ignoreClasses = [ExampleMain];
			
			// uncomment to ignore the trace output(s) from the 'ExampleMain' and 'ExampleClass2_FP9' Classes
			//Tr.ignoreClasses = [ExampleMain, ExampleClass2_FP9];
			
			
			// uncomment to restrict the trace output(s) from user 'MSFX' only
			//Tr.restrictToUsers = [TrUsers.MSFX];
			
			// uncomment to restrict the trace output(s) from users 'MSFX' AND 'DEFAULT' only
			//Tr.restrictToUsers = [TrUsers.MSFX, TrUsers.DEFAULT];
			
			// uncomment to ignore the trace output(s) from user 'MSFX' only
			//Tr.ignoreUsers = [TrUsers.MSFX];
			
			// uncomment to ignore the trace output(s) from users 'MSFX' AND 'DEFAULT' only
			//Tr.ignoreUsers = [TrUsers.MSFX, TrUsers.DEFAULT];
			
			
			// uncomment to show the time with each trace
			//Tr.useTimeStamp = true;
			
			// uncomment to add linebreaks between each output
			//Tr.useLineBreaks = true;
			
			// create a textfield to use as the "console"
			var textfield:TextField = new TextField();
			textfield.width = stage.stageWidth;
			textfield.height = stage.stageHeight;
			addChild(textfield);
			
			// uncomment to output all the traces to the textfield NB: If you want to clear the log (the output within the textfield) then look at line 268
			//Tr.console = textfield;
			
			// uncomment to switch tracing off entirely
			//Tr.enabled = true;
			
			
			
			/**
			 * Below are several uses of Tr.ace(...) from 3 different users.
			 * 
			 * The instantiation of 'TestClass' will invoke Tr.ace(...) calls from within the TestClass
			 * and adding it to the stage will invoke further calls as well as the initialization of a 
			 * third class 'AnotherTestClass' which will make once last Tr.ace(...) call.
			 */
			
			
			// now lets add a trace statement from user 'MSFX' within this 'ExampleMain' Class
			Tr.ace("Testing Tr.ace(...)!", TrUsers.MSFX, ExampleMain);
			
			// we now initialize an instance of ExampleClass1 which triggers more trace statements
			exampleClass = new ExampleClass1_FP9();
			
			// lets now trace from user 'DEFAULT' within this 'ExampleMain' Class but using 'Object(this).constructor' rather
			// than typing 'ExampleMain'.  We do this so that we have less to type should we want to duplicate the trace 
			// elsewhere and we can then also use it as a custom code snippet which can be used anywhere
			Tr.ace("About to add ExampleClass1 to the stage.", TrUsers.DEFAULT, Object(this).constructor);
			
			// add the test class to the stage - triggers more traces
			addChild(exampleClass);
			
			// one final last trace from the user 'FLASH_DEVELOP'
			Tr.ace("This is the last Tr.ace(...) call (appears in red if using FlashDevelop!)", TrUsers.FLASH_DEVELOP, Object(this).constructor);
			
			
			
			
			/**
			 * The following demonstrates the use of Tr.aceArray(...) used for the tracing of Arrays.
			 * 
			 * First, uncomment line 174 to demonstrate tracing a simple Array using Tr.aceArray(...).
			 * 
			 * Secondly, uncomment line 180 to demonstrate tracing a more complex Array using Tr.aceArray(...).
			 * This more complex Array involves several nested Arrays and Objects.
			 * 
			 * You can also toggle whether line breaks appear between standard Tr.ace(...) calls and within the Tr.aceArray(...) 
			 * and Tr.aceObject(...) calls by toggling 'Tr.arrayAndObjectLinebreaks' on line 171
			 */
			
			
			
			// set linebreaks on for Array and Object traces
			Tr.arrayAndObjectLinebreaks = true;
			
			// create an array of random elements
			var simpleArray:Array = ["simple", "array", "test", 101]; 
			
			// uncomment to trace the contents of the simpleArray using Tr.aceArray(...)
			//Tr.aceArray(simpleArray, TrUsers.MSFX, Object(this).constructor);
			
			// create an array of random, more complex elements (nested arrays and objects)
			var complexArray:Array = ["aceArray(...)", "test", 101, 123.456, ["a", "nested", "array", "test!", ["a nested", "nested", "array!"]], true, {"a":1, "b":2}, "final array element!"]; 
			
			// trace the contents of the Array using Tr.aceArray(...)
			// NB: the Object properties may not print out in the exact order they were entered due to the way they are internally stored
			//Tr.aceArray(complexArray, TrUsers.MSFX, Object(this).constructor);
			
			
			
			/**
			 * The following demonstrates the use of Tr.aceObjects(...) used for the tracing of Objects
			 * 
			 * First, uncomment line 208 to demonstrate tracing a simple Object using Tr.aceObject(...)
			 * 
			 * Secondly, uncomment line 218 to demonstrate tracing a more complex Object using Tr.aceObject(...).
			 * This more complex Object involves several nested Arrays and Objects.
			 * 
			 * Again, you can also toggle whether line breaks appear between standard Tr.ace(...) calls and within 
			 * the Tr.aceArray(...) and Tr.aceObject(...) calls by toggling 'Tr.arrayAndObjectLinebreaks' on line 161
			 */
			
			// create a simple object
			var simpleObject : Object = new Object();
			simpleObject.first = "simple";
			simpleObject.second = "stest";
			simpleObject.third = 101;
			
			// trace contents of the simpleObject using Tr.aceObject(...)
			// NB: they may not print out in the exact order they were entered due to the way they are internally stored
			//Tr.aceObject(simpleObject, TrUsers.MSFX, Object(this).constructor);
			
			var complexObject:Object = new Object();
			complexObject.first = "start of the more complex test";
			complexObject.second = ["an array", "within", "an object!", ["with a", "nested array too!"]];
			complexObject.third = { "a": 1, "b" : 2, "c" : 3, "d" : 4, "e" : 5 };
			complexObject.fourth = "end of the more complex test";
			
			// trace contents of the simpleObject using Tr.aceObject(...)
			// NB: they may not print out in the exact order they were entered due to the way they are internally stored
			//Tr.aceObject(complexObject, TrUsers.MSFX, Object(this).constructor);
			
			
			
			/**
			 * This example demonstrates the use of Tr.aceMulti(...) used for tracing a list of multiple arguments
			 * 
			 * Uncomment line 235 to demonstrate a tracing of a String, the addition of two integers, an Array and an Object all 
			 * from one statement on one line.
			 */
			
			var test:String = "multi test";
			var one:int = 1;
			var two:int = 2;
			var obj:Object = { };
			
			// trace an unlimited number of arguments seperated via commas
			//Tr.aceMulti(TrUsers.MSFX, Object(this).constructor, test, one + two, ["a", "b", "c", "d"], obj);
			
			
			
			
			/**
			 * This example demonstrates the use of Tr.ace(...) without the username or class parameters (now optional from Tr.ace() v1.5)
			 * 
			 * Uncomment line 252 to demonstrate Tr.ace(...) tracing a string without the username or class parameter
			 * Uncomment line 253 to demonstrate Tr.aceArray(...) tracing an array without the username or class parameter
			 * Uncomment line 254 to demonstrate Tr.aceObject(...) tracing an object without the username or class parameter
			 * Uncomment line 255 to demonstrate Tr.aceMulti(...) tracing multiple values without the username or class parameter
			 * 
			 * NB: Using Tr.ace() without users/classes does remove alot of "the power" from the library with regards to restricting 
			 * traces to specific users or classes but options such as the console will still function fully.
			 */
			
			//Tr.ace("This is a comment without a User OR Class! =0!");
			//Tr.aceArray([1, 2, 3, 4]);
			//Tr.aceObject( { testing: "works !" } );
			//Tr.aceMulti("", null, "testing", 1, 2, 3);
			
			
			
			/**
			 * This example demonstrates how to clear the log, useful if you're outputting "the console"
			 * 
			 * Uncomment line 268 to clear the log
			 * 
			 * NB:  The name of the textfield is automatically created as a timestamp
			 */
			
			// uncomment to clear the log
			Tr.clearLog();
			
		}
		
	}
}
