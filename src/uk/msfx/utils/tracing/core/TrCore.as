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
package uk.msfx.utils.tracing.core
{
	import flash.text.TextField;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * <p>The core Class for managing and formatting the output for Tr.ace().</p>
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class TrCore
	{
		/** @private */
		protected var settings:TrSettings = TrSettings.getInstance(); // retrieve the settings, 'Singleton' Class
		
		
		// variables to tailor the output
		
		/** @private */
		private var _arrayAndObjectLinebreaks:Boolean = false;
		
		/** @private */
		protected var clipboardText:String = "";
		
		/** @private */
		protected var _console:TextField;
		
		/** @private */
		protected var _copyToClipboard:Boolean = false;
		
		/** @private */
		private var _enabled:Boolean = false;
		
		/** @private */
		protected var _ignoreClasses:Array;
		
		/** @private */
		protected var ignoreClassesNo:int;
		
		/** @private */
		protected var _ignoreUsers:Array;
		
		/** @private */
		protected var ignoreUsersNo:int;
		
		/** @private */
		private var _log:String = "";
		
		/** @private */
		protected var _restrictToClasses:Array;
		
		/** @private */
		protected var restrictToClassesNo:int;
		
		/** @private */
		protected var _restrictToUsers:Array; 
		
		/** @private */
		protected var restrictToUsersNo:int;
		
		/** @private */
		protected var _useLineBreaks:Boolean = false;
		
		/** @private */
		protected var _useTimeStamp:Boolean = false;
		
		
		// for adding the timestamp
		
		/** @private */
		protected var date:Date;
		
		
		/**
		 * Constructor, initializes the Class, applying all the settings from the settings instance.
		 */
        public function TrCore() 
		{
			// apply settings to this instance
			_restrictToClasses = settings.restrictToClasses;
			restrictToClassesNo = _restrictToClasses.length;
			
			_restrictToUsers = settings.restrictToUsers;
			restrictToUsersNo = _restrictToUsers.length;
			
			_ignoreClasses = settings.ignoreClasses;
			ignoreClassesNo = _ignoreClasses.length;
			
			_ignoreUsers = settings.ignoreUsers;
			ignoreUsersNo = _ignoreUsers.length;
			
			useTimeStamp = settings.useTimeStamp;
			
			useLineBreaks = settings.useLineBreaks
			arrayAndObjectLinebreaks = settings.arrayAndObjectLinebreaks;
			
			enabled = settings.enabled;
			
			// initialize the date
			date = new Date();
        }
		
		/**
		 * Function to format and trace the contents of an Array to the console.
		 * 
		 * @param	output			The Array that you wish to trace to the console
		 * @param	user			<b>OPTIONAL: </b>The name of the user tracing the output
		 * @param	withinClass		<b>OPTIONAL: </b>The name of the Class being traced from
		 * @param	level			<b>OPTIONAL: </b>How many levels the current Array is (support for nested arrays)
		 */
		public function outArray(output:Array, user:String = "", withinClass:* = null, level:int = 0):void 
		{
			// length of array
			var le:int = output.length;
			
			// prefix variable
			var prefix:String = "";
			
			// datatype of element
			var type:Object;
			
			// if tracing nested array, add a prefix
			for (var j:int = 0; j < level; j++) prefix += "- ";
			
			// start trace for Array with length
			out(prefix + "Begin Array Trace (" + le + ")", user, withinClass, arrayAndObjectLinebreaks);
			
			// loop over array tracing each element
			for (var i:int = 0; i < le; i++) 
			{
				// retrieve type of the element
				type = getQualifiedClassName(output[i]);
				
				// if element is nested array
				if (type == "Array") 
				{
					// recursive call 
					out(prefix + "- [" + i + "] => Array (" + output[i].length +")", user, withinClass);
					outArray(output[i], user, withinClass, level + 1);
				}
				else if (type == "Object")
				{
					out(prefix + "- [" + i + "] => Object", user, withinClass);
					outObject(output[i], user, withinClass, level + 2);
				}
				else
				{
					// trace out
					out(prefix + "- [" + i + "] => " + output[i], user, withinClass);
				}
			}
			
			// end trace for Array
			out(prefix + "End Array Trace (" + le + ")", user, withinClass, false, arrayAndObjectLinebreaks);
		}
		
		/**
		 * Function to trace multiple values out, seperated by commas.
		 * 
		 * @param	values 			Array of values to be traced out
		 * @param	user			<b>OPTIONAL: </b>The user tracing the values
		 * @param	withinClass		<b>OPTIONAL: </b>The class being traced from
		 */
		public function outMulti(values:Array, user:String = "", withinClass:* = null):void 
		{
			var le:int = values.length;
			var traceStr:String = "";
			
			for (var i:int = 0; i < le; i++) 
			{
				// if an Array add array brackets
				if (values[i] is Array)
				{
					traceStr += ("[" + values[i] + "]");
				}
				else // else just trace value
				{
					traceStr += (values[i]);
				}
				
				// add comma to seperate elements
				if (i < le-1) traceStr += ", ";
			}
			
			// trace it out
			out(traceStr, user, withinClass);
		}
		
		/**
		 * Function to format and trace the contents of an Object to the console.
		 * 
		 * @param	output			The Object that you wish to trace to the console
		 * @param	user			<b>OPTIONAL: </b>The name of the user tracing the output
		 * @param	withinClass		<b>OPTIONAL: </b>The name of the Class being traced from
		 * @param	level			<b>OPTIONAL: </b>How many levels the current Object is (support for nested Objects)
		 */
		public function outObject(output:Object, user:String = "", withinClass:* = null, level:int = 0):void
		{
			// prefix variable
			var prefix:String = "";
			
			// datatype of element
			var type:Object;
			
			// if tracing nested object, add a prefix
			for (var i:int = 0; i < level; i++) prefix += "- ";
			
			// start trace for Object
			out(prefix + "Begin Object Trace", user, withinClass, arrayAndObjectLinebreaks);
			
			// loop over object tracing each property
			for (var p:* in output)
			{
				// retrieve type of the element
				type = getQualifiedClassName(output[p]);
				
				if (type == "Array")
				{
					out(prefix + "- [" + p + "] => Array", user, withinClass);
					outArray(output[p], user, withinClass, level + 1);
				}
				else if (type == "Object")
				{
					out(prefix + "- [" + p + "] => Object", user, withinClass);
					outObject(output[p], user, withinClass, level + 1);
				}
				else
				{
					out(prefix + "- [" + p + "] => " + output[p], user, withinClass);
				}
				
			}
			
			// end trace for Object
			out(prefix + "End Object Trace", user, withinClass, false, arrayAndObjectLinebreaks);
		}
		
		/**
		 * Function to format and trace to the output console.
		 * 
		 * @param	output 					The output that you wish to trace to the console
		 * @param	user 					<b>OPTIONAL: </b>The name of the user tracing the output
		 * @param	withinClass				<b>OPTIONAL: </b>The name of the Class the output is being traced from
		 * @param	startWithLineBreak 		<b>OPTIONAL: </b>Whether to start the trace with a line break
		 * @param	endWithLineBreak 		<b>OPTIONAL: </b>Whether to end the trace with a line break
		 */
		public function out(output:*, user:String = "", withinClass:* = null, startWithLineBreak:Boolean = false, endWithLineBreak:Boolean = false):void 
		{
			// if there are restrictions on which classes to trace from test for match, else kill the function
			if (_restrictToClasses.length > 0 && _restrictToClasses.indexOf(withinClass) < 0) return;
			
			// if there are classes to ignore output from test for match, if positive kill the function
			if (_ignoreClasses.length > 0 && _ignoreClasses.indexOf(withinClass) >= 0) return;
			
			// if there are users to ignore output from test for match, if positive kill the function
			if (_ignoreUsers.length > 0 && _ignoreUsers.indexOf(user) >= 0) return;
			
			// output variable
			var traceStr:String = "";
			
			// add initial linebreak if toggled on
			if (startWithLineBreak) traceStr = "\n";
			
			// add the time
			if (_useTimeStamp) traceStr = "(" + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + ":" + date.getMilliseconds() + ") ";
			
			// add the users name
			if (user.length > 0) traceStr += user.toUpperCase() + " ";
			
			// add the class tracing from
			if (withinClass != null) traceStr += withinClass + " - ";
			
			// if there are restrictions on which users to trace from
			if (_restrictToUsers.length > 0)
			{
				// test for match with user
				if (_restrictToUsers.indexOf(user) >= 0) 
				{
					// trace the users output
					trace(traceStr + output);
					
					// update log
					//_log += ((traceStr + output) + "\n");
					_log += ((traceStr + output) + String.fromCharCode(13));
					
					// update the clipboard if enabled
					if (_copyToClipboard) clipboardText = _log;
					
					// push out to the console if enabled
					if (_console) _console.appendText(traceStr + output + "\n");
				}
			}
			else 
			{
				// otherwise just trace every users output
				trace(traceStr + output);
				
				// update log
				//_log += ((traceStr + output) + "\n");
				_log += ((traceStr + output) + String.fromCharCode(13));
				
				// update the clipboard if enabled
				if (_copyToClipboard) clipboardText = _log;
				
				// push out to the console if enabled
				if (_console) _console.appendText(traceStr + output + "\n");
			}
			
			// toggle for linebreaks
			if (_useLineBreaks)
			{
				trace("");
				
				// update log
				_log += "\n";
				
				// update the clipboard if enabled
				if (_copyToClipboard) clipboardText += "\n";
				
				// update the console if enabled
				if (_console) _console.appendText("\n");
			}
			
			// add initial linebreak if toggled on
			if (endWithLineBreak) 
			{
				trace("");
				
				// update log
				_log += "\n";
				
				// update the clipboard if enabled
				if (_copyToClipboard) clipboardText += "\n";
				
				// update the console if enabled
				if (_console) _console.appendText("\n");
			}
		}
		
		
		/** @private */
		public function get arrayAndObjectLinebreaks():Boolean { return settings.arrayAndObjectLinebreaks; }
		
		/** @private */
		public function get console():TextField { return settings.console; }
		
		/** @private */
		public function get ignoreClasses():Array { return settings.ignoreClasses; }
		
		/** @private */
		public function get ignoreUsers():Array { return settings.ignoreUsers; }
		
		/** @private */
		public function get enabled():Boolean { return settings.enabled; }
		
		/** @private */
		public function get log():String { return _log; }
		
		/** @private */
		public function get restrictToClasses():Array { return settings.restrictToClasses; }
		
		/** @private */
		public function get restrictToUsers():Array { return settings.restrictToUsers; }
		
		/** @private */
		public function get useLineBreaks():Boolean { return settings.useLineBreaks; }
		
		/** @private */
		public function get useTimeStamp():Boolean { return settings.useTimeStamp; }
		
		
		/** @private */
		public function set arrayAndObjectLinebreaks(value:Boolean):void { settings.arrayAndObjectLinebreaks = _arrayAndObjectLinebreaks = value; }
		
		/** @private */
		public function set console(value:TextField):void { settings.console = _console = value; }
		
		/** @private */
		public function set ignoreClasses(value:Array):void { settings.ignoreClasses = _ignoreClasses = value; }
		
		/** @private */
		public function set ignoreUsers(value:Array):void { settings.ignoreUsers = _ignoreUsers = value; }
		
		/** @private */
		public function set enabled(value:Boolean):void { settings.enabled = _enabled = value; }
		
		/** @private */
		public function set restrictToClasses(value:Array):void { settings.restrictToClasses = _restrictToClasses = value; }
        
		/** @private */
		public function set restrictToUsers(value:Array):void { settings.restrictToUsers = _restrictToUsers = value; }
		
		/** @private */
		public function set useLineBreaks(value:Boolean):void { settings.useLineBreaks = _useLineBreaks = value; }
		
		/** @private */
		public function set useTimeStamp(value:Boolean):void { settings.useTimeStamp = _useTimeStamp = value; }
		
	}
}