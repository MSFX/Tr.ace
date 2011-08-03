/**
 * Tr.ace() by MSFX Matt Stuttard
 * Version 1.1
 * 03.08.2011
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
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * <p>The core Class for managing and formatting the output for Tr.ace().</p>
	 */
	public class TrCore
	{
		
		// Singleton setup variables
		
		/** @private */
		private static const _instance:TrCore = new TrCore(SingletonLock);
		
		/** @private */
		private var _initialized:Boolean = false;
		
		
		// variables to tailor the output
		
		/**
		 * @private
		 * Using Array (not Vector of Class) to allow support for FP9
		 */
		private var _restrictToClasses:Array;
		
		/** @private */
		internal var restrictToClassesNo:int;
		
		/**
		 * @private
		 * Using Array (not Vector of String) to allow support for FP9
		 */
		private var _restrictToUsers:Array; 
		
		/** @private */
		internal var restrictToUsersNo:int;
		
		/** @private */
		private var date:Date;
		
		/** @private */
		internal var useTimeStamp:Boolean = false;
		
		/** @private */
		internal var copyToClipboard:Boolean = false;
		
		/** @private */
		private var clipboardText:String = "";
		
		/** @private */
		internal var useLineBreaks:Boolean = false;
		
		/** @private */
		internal var arrayAndObjectLinebreaks:Boolean = false;
		
		/** @private */
		internal var off:Boolean = false;
		
		
		/**
		 * Constructor.
		 * 
		 * <p>This Class uses a Singleton design pattern, the SingletonLock Class is passed via the <code>lock</code> parameter to mimmick the Singleton design.</p>
		 * @param	lock Class used to mimmick 'Singleton'
		 */
        public function TrCore(lock:Class) 
		{
			// throw error if incorrectly instantiated
            if (lock != SingletonLock) throw new Error("Invalid TrCore access. Use TrCore.instance");
			
			// initialize
            initialize();
        }
        
		/**
		 * <p>Function to "initialise" the Class and prevent from initializing more than once.</p>
		 */
        private function initialize():void 
		{
            //we only need to initialize once. 
            if (_initialized) return;
			
			// initialize the date
			date = new Date();
			
            _initialized = true;
        }
		
		/**
		 * Function to format and trace the contents of an Array to the console.
		 * 
		 * <p>The <b>Tr.DEFAULT</b> user will be used if no username is entered.</p>
		 * 
		 * @param	output			The Array that you wish to trace to the console
		 * @param	user			The name of the user tracing the output
		 * @param	withinClass		The name of the Class being traced from
		 * @param	level			how many levels the current Array is (support for nested arrays)
		 */
		internal function outArray(output:Array, user:String = "default", withinClass:Class = null, level:int = 0):void 
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
		 * Function to format and trace the contents of an Object to the console.
		 * 
		 * <p>The <b>Tr.DEFAULT</b> user will be used if no username is entered.</p>
		 * 
		 * @param	output			The Object that you wish to trace to the console
		 * @param	user			The name of the user tracing the output
		 * @param	withinClass		The name of the Class being traced from
		 * @param	level			how many levels the current Object is (support for nested Objects)
		 */
		internal function outObject(output:Object, user:String = "default", withinClass:Class = null, level:int = 0):void
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
		 * <p>The <b>Tr.DEFAULT</b> user will be used if no username is entered.</p>
		 * 
		 * @param	output 			The output that you wish to trace to the console
		 * @param	user 			The name of the user tracing the output
		 * @param	withinClass		The name of the Class the output is being traced from
		 */
		internal function out(output:*, user:String = "default", withinClass:Class = null, startWithLineBreak:Boolean = false, endWithLineBreak:Boolean = false):void 
		{
			// if there are restrictions on which classes to trace from test for match, else kill the function
			if (restrictToClassesNo > 0 && restrictToClasses.indexOf(withinClass) < 0) return;
			
			// output variable
			var traceStr:String = "";
			
			// add initial linebreak if toggled on
			if (startWithLineBreak) traceStr = "\n";
			
			// add the time
			if (useTimeStamp) traceStr = "(" + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + ":" + date.getMilliseconds() + ") ";
			
			// add the users name
			traceStr += user.toUpperCase() + " ";
			
			// add the class tracing from if specified
			if (withinClass != null) traceStr += withinClass + " - ";
			else traceStr += " - ";
			
			// if there are restrictions on which users to trace from
			if (restrictToUsersNo > 0)
			{
				// test for match with user
				if (restrictToUsers.indexOf(user) >= 0) 
				{
					// trace the users output
					trace(traceStr + output);
					
					// update the clipboard
					clipboardText += (traceStr + output) + "\n";
				}
			}
			else 
			{
				// otherwise just trace every users output
				trace(traceStr + output);
				
				// update the clipboard
				clipboardText += (traceStr + output) + "\n";
			}
			
			// toggle for linebreaks
			if (useLineBreaks)
			{
				trace("");
				clipboardText += "\n";
			}
			
			// add initial linebreak if toggled on
			if (endWithLineBreak) 
			{
				trace("");
				clipboardText += "\n";
			}
			
			// copy to the clipboard
			if (copyToClipboard) Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, clipboardText);
		}
		
		/**
		 * Function to trace multiple values out, seperated by commas.
		 * 
		 * @param	values Array of values to be traced out
		 * @param	user
		 * @param	withinClass
		 */
		internal function outMulti(values:Array, user:String = "default", withinClass:Class = null):void 
		{
			var le:int = values.length;
			var traceStr:String = "";
			
			for (var i:int = 0; i < le; i++) 
			{
				if (values[i] is Array)
				{
					traceStr += ("[" + values[i] + "], ");
				}
				else
				{
					traceStr += (values[i]) + ", ";
				}
			}
			
			out(traceStr, user, withinClass);
		}
		
		
		/** @private */
		public static function get instance() : TrCore { return _instance; }
        
		/** @private */
		public function get initialized():Boolean { return _initialized; }
		
		/** @private */
		public function get restrictToClasses():Array { return _restrictToClasses; }
		
		/** @private */
		public function get restrictToUsers():Array { return _restrictToUsers; }
		
		
		/** @private */
		public function set restrictToClasses(value:Array):void 
		{
			_restrictToClasses = value;
			
			// update the number of classes restricted to
			restrictToClassesNo = _restrictToClasses.length;
		}
        
		/** @private */
		public function set restrictToUsers(value:Array):void 
		{
			_restrictToUsers = value;
			
			// update the number of users restricted to
			restrictToUsersNo = _restrictToUsers.length;
		}
		
	}
	
}

//this is used to lock the Singleton
class SingletonLock{}