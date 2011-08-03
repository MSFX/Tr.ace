/**
 * Tr.ace() by MSFX Matt Stuttard
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
package uk.msfx.utils.tracing
{
	/**
	 * Tr.ace() is a library for managing trace statements within AS3.
	 * 
	 * <p>Tr.ace() is a static Class that uses the Singleton design pattern so you only need to define it's settings once within your application and you're all set.</p>
	 * 
	 * <p>With Tr.ace() you can manage all your output statements, restricting your applications traces to specific users and/or even specific Classes.  Or you can toggle tracing off entirely.</p>
	 * 
	 * <p>The output using Tr.ace() can also be formatted with timestamps, linebreaks, the name of the user tracing, the Class the trace resides within and can be automatically copied to the clipboard.</p>
	 * 
	 * <p>For those using FlashDevelop you can prefix your username with "0:", "1:", "2:", "3:", or "4:" to trace in a different colour within the FlashDevelop output console, as shown with the 'FLASH_DEVELOP' username included.</p>
	 * 
	 * <p>Tr.ace() has been extended to now feature Tr.aceArray(...) and Tr.aceObject(...), two functions that will save you alot of time when tracing Arrays and Objects to the output console.</p>
	 * 
	 */
	public class Tr 
	{
		// the tracing engine TrCore is a singleton so only one instance will ever exist
		private static var core:TrCore = TrCore.instance;
		
		// variables to tailor the output
		private static var _arrayAndObjectLinebreaks:Boolean;
		private static var _copyToClipboard:Boolean;
		private static var _off:Boolean;
		private static var _restrictToClasses:Array;
		private static var _restrictToUsers:Array;
		private static var _useTimeStamp:Boolean;
		private static var _useLineBreaks:Boolean;
		
		
		/**
		 * Default User
		 */
		public static const DEFAULT:String = "default";
		
		/**
		 * Flash Develop Example User
		 * 
		 * <p>Prefixed with "3:" so the output will be red within the FlashDevelop output console.</p>
		 */
		public static const FLASH_DEVELOP:String = "3:flashdevelop";
		
		/**
		 * Author User
		 */
		public static const MATT:String = "matt";
		
		// add your own usernames here
		
		
		/**
		 * Static Class, Unused Constructor.
		 */
		public function Tr() {	}
		
		
		/**
		 * Function to trace to the output console.
		 * 
		 * <p>The user and Class parameters are optional, although Tr.ace() is far more powerful with all 3 parameters.</p>
		 * 
		 * <p>Examples:</p>
		 * 
		 * <p><code>Tr.ace("This is a trace statement", Tr.MATT, ClassName);</code></p>
		 * 
		 * <p><code>Tr.ace(4 + 21 + variableName, Tr.YOUR_USERNAME, AnotherClassName);</code></p>
		 * 
		 * <p><code>Tr.ace("without the username or classname");</code></p>
		 * 
		 * <p><b>NB:</b> The <b>Tr.DEFAULT</b> user will be used if no username is entered.</p>
		 * 
		 * @param	output 			The output that you wish to trace to the console
		 * @param	user 			<b>OPTIONAL</b> The name of the user tracing the output
		 * @param	withinClass		<b>OPTIONAL</b> The name of the Class the output is being traced from
		 */
		public static function ace(output:*, user:String = "default", withinClass:Class = null):void 
		{
			// trace the output to the console if tracing is on
			if (!core.off) core.out(output, user, withinClass);
		}
		
		/**
		 * Function to trace the elements of an Array to the output console, in a neatly formatted manner.
		 * 
		 * <p>The user and Class parameters are optional, although Tr.aceArray() is far more powerful with all 3 parameters.</p>
		 * 
		 * <p>Examples:</p>
		 * 
		 * <p><code>Tr.aceArray(["array", "test", 101, true], Tr.MATT, ClassName);</code></p>
		 * 
		 * <p><code>var dummyArray:Array = ["array", "test", 101, true]; 
		 * Tr.aceArray(dummyArray, Tr.YOUR_USERNAME, AnotherClassName);</code></p>
		 * 
		 * <p><code>Tr.aceArray(["without", "username or", "classname"]);</code></p>
		 * 
		 * <p><b>NB:</b> The <b>Tr.DEFAULT</b> user will be used if no username is entered.</p>
		 * 
		 * @param	output			The Array that you wish to trace to the console
		 * @param	user			<b>OPTIONAL</b> The name of the user tracing the output
		 * @param	withinClass		<b>OPTIONAL</b> The name of the Class the output is being traced from
		 */
		public static function aceArray(output:Array, user:String = "default", withinClass:Class = null):void 
		{
			// trace the output to the console if tracing is on
			if (!core.off) core.outArray(output, user, withinClass);
		}
		
		/**
		 * Function to trace the properties of an Object to the output console, in a neatly formatted manner.
		 * 
		 * <p>The user and Class parameters are optional, although Tr.aceObject() is far more powerful with all 3 parameters.</p>
		 * 
		 * <p>Examples:</p>
		 * 
		 * <p><code>Tr.aceObject({"a" : 1, "b" : 2, "c" : 3], Tr.MATT, ClassName);</code></p>
		 * 
		 * <p><code>var dummyObject:Object = {"array test" : [1, 2, 3], "numbers" : 123.456, "obj" : {"a" : 1, "b" : 2, "c" : 3} }; 
		 * Tr.aceArray(dummyObject, Tr.DEFAULT, AnotherClassName);</code></p>
		 * 
		 * <p><b>NB:</b> The <b>Tr.DEFAULT</b> user will be used if no username is entered.</p>
		 * 
		 * @param	output			The Object that you wish to trace to the console
		 * @param	user			<b>OPTIONAL</b> The name of the user tracing the output
		 * @param	withinClass		<b>OPTIONAL</b> The name of the Class the output is being traced from
		 */
		public static function aceObject(output:Object, user:String = "default", withinClass:Class = null):void 
		{
			if (!core.off) core.outObject(output, user, withinClass);
		}
		
		
		/**
		 * Function to trace multiple values out to the console.
		 * 
		 * <p>User and Class are requested first since nothing can preceed '...values'.</p>
		 * 
		 * <p>Example:</p>
		 * 
		 * <p><code>Tr.aceMulti(Tr.DEFAULT, ClassName, "string to trace", 1.2 + 4.5, ["array", "to", "trace"]);</code></p>
		 * 
		 * @param	user			<b>OPTIONAL</b> The name of the user tracing the output
		 * @param	withinClass		<b>OPTIONAL</b> The name of the Class the output is being traced from
		 * @param	...values		The values that you wish to trace to the console
		 */
		public static function aceMulti(user:String = "default", withinClass:Class = null, ...values):void 
		{
			if (!core.off) core.outMulti(values, user, withinClass);
		}
		
		/**
		 * Toggle whether a line break will be added at the beginning and end of a Tr.aceArray() or Tr.aceObject() call.
		 */
		static public function get arrayAndObjectLinebreaks():Boolean { return core.arrayAndObjectLinebreaks; }
		
		
		/**
		 * Toggle whether the output is automatically updated to the clipboard.
		 */
		static public function get copyToClipboard():Boolean { return core.copyToClipboard; }
		
		/**
		 * Toggle whether the output is on or off
		 */
		static public function get off():Boolean { return core.off; }
		
		/**
		 * An Array of Classes (Class) that you wish the output to be restricted to.
		 * 
		 * <p>Example:</p>
		 * 
		 * <p>To restrict the output from only your <code>Main</code> class you would use the following:</p>
		 * 
		 * <p><code>Tr.restrictToClasses = [Main];</code></p>
		 * 
		 * <p>or to restrict to multiple classes</p>
		 * 
		 * <p><code>Tr.restrictToClasses = [ClassName1, ClassName2];</code></p>
		 */
		static public function get restrictToClasses():Array { return core.restrictToClasses; }
		
		/**
		 * An Array of users (Strings) that you wish the output to be restricted to.
		 * 
		 * <p>Example:</p>
		 * 
		 * <p>To restrict the output from the <b>DEFAULT</b> user you would use the following:</p>
		 * 
		 * <p><code>Tr.restrictToClasses = [Tr.DEFAULT];</code></p>
		 * 
		 * <p>or to restrict to multiple users</p>
		 * 
		 * <p><code>Tr.restrictToClasses = [UserName1, UserName2];</code></p>
		 * 
		 * <p><b>NB:</b> I suggest you add your username(s) to this class rather than entering a String each time (removing the risk of typos).</p>
		 */
		static public function get restrictToUsers():Array { return core.restrictToUsers; }
		
		/**
		 * Toggle whether each trace feautures a timestamp (HH:MM:SS:MS).
		 */
		static public function get useTimeStamp():Boolean { return core.useTimeStamp; }
		
		/**
		 * Toggle whether the output (and clipboard if toggled on) has line breaks inbetween each trace.
		 */
		static public function get useLineBreaks():Boolean { return core.useLineBreaks; }
		
		
		/** @private */
		static public function set arrayAndObjectLinebreaks(value:Boolean):void { core.arrayAndObjectLinebreaks = value; }
		
		/** @private */
		static public function set copyToClipboard(value:Boolean):void { core.copyToClipboard = value; }
		
		/** @private */
		static public function set off(value:Boolean):void { core.off = value; }
		
		/** @private */
		static public function set restrictToClasses(value:Array):void { core.restrictToClasses = value; }
		
		/** @private */
		static public function set restrictToUsers(value:Array):void { core.restrictToUsers = value; }
		
		/** @private */
		static public function set useTimeStamp(value:Boolean):void { core.useTimeStamp = value; }
		
		/** @private */
		static public function set useLineBreaks(value:Boolean):void { core.useLineBreaks = value; }
		
	}
}