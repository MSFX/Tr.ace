/**
 * Tr.ace() by MSFX Matt Stuttard Parker
 * Version 1.5
 * 15.04.2012
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
package uk.msfx.utils.tracing.fp10
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.net.FileReference;
	import flash.text.TextField;
	import uk.msfx.utils.tracing.core.TrCore;
	
	/**
	 * Tr.ace() is a library for managing trace statements within AS3 (Flash Player 10 Version).
	 * 
	 * <p>Tr.ace() is a static Class that uses the Singleton design pattern so you only need to define it's settings once within your application and you're all set.</p>
	 * 
	 * <p>With Tr.ace() you can manage all your output statements, restricting or ignoring your applications traces to specific users and/or even specific Classes.  Or you can toggle tracing off entirely.</p>
	 * 
	 * <p>The output using Tr.ace() can also be formatted with timestamps, linebreaks, the name of the user tracing, the Class the trace resides within and can be automatically copied to the clipboard.</p>
	 * 
	 * <p>For those using FlashDevelop you can prefix your username with "0:", "1:", "2:", "3:", or "4:" to trace in a different colour within the FlashDevelop output console, as shown with the 'FLASH_DEVELOP' username included.</p>
	 * 
	 * <p><b>UPDATE 1.1:</b>  The Tr.ace() library has been extended to feature Tr.aceArray(...) and Tr.aceObject(...), two functions to neatly format Arrays and Objects within the output console.</p>
	 * 
	 * <p><b>UPDATE 1.2:</b>  The Tr.ace() library has been extended again to feature Tr.aceMulti(...), a function to trace an unlimited number of arguments all on one line.</p>
	 * 
	 * <p><b>UPDATE 1.3:</b>  Updated to support Flash Player 9 (removed clipboard functionality from fp9 branch).</p>
	 * 
	 * <p><b>UPDATE 1.4:</b>  The Tr.ace() library has been extended to include a 'console' in the form of a textfield that all your traces are output to.  For those working off the FP10 branch a new 'log' feature has also been integrated allowing you to output the traces to a .txt file.</p>
	 * 
	 * <p><b>UPDATE 1.5:</b>  To make the library more accessible and less "verbose" for simple quick use the username and class are now <b>OPTIONAL</b> parameters.</p>
	 * 
	 * <p><b>UPDATE 1.6:</b>  Rearchitectured Clipboard (FP10 Branch only) and Logging functionality to work together more sensibly.  To copy to clipboard you must now call Tr.copyLogToClipboard().  You can also clear the log using Tr.clearLog()
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class Tr 
	{
		// the tracing engine TrCore is a singleton so only one instance will ever exist
		private static var core:TrCore = new TrCore();
		
		// variables to tailor the output
		private static var _arrayAndObjectLinebreaks:Boolean;
		private static var _console:TextField;
		private static var _enabled:Boolean;
		private static var _restrictToClasses:Array;
		private static var _ignoreClasses:Array;
		private static var _restrictToUsers:Array;
		private static var _ignoreUsers:Array;
		private static var _useTimeStamp:Boolean;
		private static var _useLineBreaks:Boolean;
		
		// file reference variable used to save log with
		protected static var file:FileReference;
		
		
		/**
		 * Static Class, Unused Constructor.
		 */
		public function Tr() {	}
		
		
		/**
		 * Function to trace to the output console.
		 * 
		 * <p>Examples:</p>
		 * 
		 * <p><code>Tr.ace("This is a trace statement", TrUsers.MATT, ClassName);</code></p>
		 * 
		 * <p><code>Tr.ace(4 + 21 + variableName, TrUsers.YOUR_USERNAME, AnotherClassName);</code></p>
		 * 
		 * @param	output 			The output that you wish to trace to the console
		 * @param	user 			<b>OPTIONAL: </b>The name of the user tracing the output
		 * @param	withinClass		<b>OPTIONAL: </b>The name of the Class the output is being traced from
		 */
		public static function ace(output:*, user:String = "", withinClass:Class = null):void 
		{
			// trace the output to the console if tracing is on
			if (!core.enabled) core.out(output, user, withinClass);
		}
		
		/**
		 * Function to trace the elements of an Array to the output console, in a neatly formatted manner.
		 * 
		 * <p>Examples:</p>
		 * 
		 * <p><code>Tr.aceArray(["array", "test", 101, true], TrUsers.MATT, ClassName);</code></p>
		 * 
		 * <p><code>var dummyArray:Array = ["array", "test", 101, true]; 
		 * Tr.aceArray(dummyArray, TrUsers.YOUR_USERNAME, AnotherClassName);</code></p>
		 * 
		 * @param	output			The Array that you wish to trace to the console
		 * @param	user			<b>OPTIONAL: </b>The name of the user tracing the output
		 * @param	withinClass		<b>OPTIONAL: </b>The name of the Class the output is being traced from
		 */
		public static function aceArray(output:Array, user:String = "", withinClass:Class = null):void 
		{
			// trace the output to the console if tracing is on
			if (!core.enabled) core.outArray(output, user, withinClass);
		}
		
		/**
		 * Function to trace the properties of an Object to the output console, in a neatly formatted manner.
		 * 
		 * <p>Examples:</p>
		 * 
		 * <p><code>Tr.aceObject({"a" : 1, "b" : 2, "c" : 3], TrUsers.MATT, ClassName);</code></p>
		 * 
		 * <p><code>var dummyObject:Object = {"array test" : [1, 2, 3], "numbers" : 123.456, "obj" : {"a" : 1, "b" : 2, "c" : 3} }; 
		 * Tr.aceObject(dummyObject, TrUsers.DEFAULT, AnotherClassName);</code></p>
		 * 
		 * @param	output			The Object that you wish to trace to the console
		 * @param	user			<b>OPTIONAL: </b>The name of the user tracing the output
		 * @param	withinClass		<b>OPTIONAL: </b>The name of the Class the output is being traced from
		 */
		public static function aceObject(output:Object, user:String = "", withinClass:Class = null):void 
		{
			if (!core.enabled) core.outObject(output, user, withinClass);
		}
		
		
		/**
		 * Function to trace multiple values out to the console.
		 * 
		 * <p>The User and Class are requested first since nothing can preceed '...values'.</p>
		 * 
		 * <p>Example:</p>
		 * 
		 * <p><code>Tr.aceMulti(TrUsers.DEFAULT, ClassName, "string to trace", 1.2 + 4.5, ["array", "to", "trace"]);</code></p>
		 * 
		 * @param	user			<b>OPTIONAL: </b>The name of the user tracing the output
		 * @param	withinClass		<b>OPTIONAL: </b>The name of the Class the output is being traced from
		 * @param	...values		<b>OPTIONAL: </b>The values that you wish to trace to the console
		 */
		public static function aceMulti(user:String = "", withinClass:* = null, ...values):void 
		{
			if (!core.enabled) core.outMulti(values, user, withinClass);
		}
		
		/**
		 * Save the current Tr.ace(...) log out to a text file.
		 * 
		 * <p>Log file will be time stamped by default in the format "DD-MM-YYYY-HHMM".</p>
		 */
		public static function saveLog():void 
		{
			// create data
			var date:Date = new Date();
			
			// generate filename
			var filename:String = "TRACE-LOG-" + ((date.date < 10)? "0" + date.date : date.date) + "-" + (((date.month + 1) < 10)? "0" + (date.month + 1) : date.month) + "-" + date.fullYear + "-" + ((date.hours < 10)? "0" + date.hours : date.hours) + ((date.minutes < 10)? "0" + date.minutes : date.minutes) + ".txt";
			
			// create new file reference
			file = new FileReference();
			
			// save the log file from from the core as the filename above
			file.save(core.log, filename);
		}
		
		/**
		 * Clear the current log
		 */
		public static function clearLog():void 
		{
			core.clearLog();
		}
		
		/**
		 * Copy the current log to the Clipboard
		 * 
		 * <p>Requires Flash Player 10+</p>
		 */
		public static function copyLogToClipboard():void 
		{
			Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, core.log);
		}
		
		/**
		 * Toggle whether a line break will be added at the beginning and end of a Tr.aceArray() or Tr.aceObject() call.
		 */
		static public function get arrayAndObjectLinebreaks():Boolean { return core.arrayAndObjectLinebreaks; }
		
		
		/**
		 * Assign a Textfield as a "console" to output the traces to.
		 * 
		 * <p>You can then position this textfield wherever you wish and toggle it visible etc to mimic a "real console".</p>
		 */
		static public function get console():TextField{ return core.console; }
		
		
		/**
		 * An Array of Classes (Class) that you wish the output to ignore.
		 * 
		 * <p>Example:</p>
		 * 
		 * <p>To ignore the output from only your <code>ClassName1</code> class you would use the following:</p>
		 * 
		 * <p><code>Tr.ignoreClasses = [ClassName1];</code></p>
		 * 
		 * <p>or to ignore from multiple classes</p>
		 * 
		 * <p><code>Tr.ignoreClasses = [ClassName1, ClassName2];</code></p>
		 */
		static public function get ignoreClasses():Array { return core.ignoreClasses; }
		
		
		
		/**
		 * An Array of Users (String) that you wish the output to ignore.
		 * 
		 * <p>Example:</p>
		 * 
		 * <p>To ignore the output from the <code>DEFAULT</code> user you would use the following:</p>
		 * 
		 * <p><code>Tr.ignoreUsers = [TrUsers.DEFAULT];</code></p>
		 * 
		 * <p>or to ignore from multiple users</p>
		 * 
		 * <p><code>Tr.ignoreUsers = [TrUsers.DEFAULT, TrUsers.MATT];</code></p>
		 */
		static public function get ignoreUsers():Array { return core.ignoreUsers; }
		
		
		/**
		 * Toggle whether the output is on or off.
		 */
		static public function get enabled():Boolean { return core.enabled; }
		
		/**
		 * An Array of Classes (Class) that you wish the output to be restricted to.
		 * 
		 * <p>Example:</p>
		 * 
		 * <p>To restrict the output from only your <code>ClassName1</code> class you would use the following:</p>
		 * 
		 * <p><code>Tr.restrictToClasses = [ClassName1];</code></p>
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
		 * <p><code>Tr.restrictToUsers = [TrUsers.DEFAULT];</code></p>
		 * 
		 * <p>To restrict to multiple users you would simply do this:</p>
		 * 
		 * <p><code>Tr.restrictToUsers = [TrUsers.DEFAULT, TrUsers.MATT];</code></p>
		 * 
		 * <p><b>NB:</b> I suggest you add your username(s) to the TrUsers class rather than entering a String each time (removing the risk of typos).</p>
		 */
		static public function get restrictToUsers():Array { return core.restrictToUsers; }
		
		/**
		 * Toggle whether the output has line breaks between each trace.
		 */
		static public function get useLineBreaks():Boolean { return core.useLineBreaks; }
		
		/**
		 * Toggle whether each trace features a timestamp (HH:MM:SS:MS).
		 */
		static public function get useTimeStamp():Boolean { return core.useTimeStamp; }
		
		
		/** @private */
		static public function set arrayAndObjectLinebreaks(value:Boolean):void { core.arrayAndObjectLinebreaks = value; }
		
		/** @private */
		static public function set console(value:TextField):void { core.console = value; }
		
		/** @private */
		static public function set enabled(value:Boolean):void { core.enabled = value; }
		
		/** @private */
		static public function set ignoreClasses(value:Array):void { core.ignoreClasses = value; }
		
		/** @private */
		static public function set ignoreUsers(value:Array):void { core.ignoreUsers = value; }
		
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