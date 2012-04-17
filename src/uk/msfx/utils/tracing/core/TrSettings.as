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
	
	/**
	 * A 'Singleton Class' to store the settings across the Tr.ace() library.
	 * 
	 * <p>Thanks to Grant Skinner for his article on Singletons - <a href="http://gskinner.com/blog/archives/2006/07/as3_singletons.html" target ="_blank">http://gskinner.com/blog/archives/2006/07/as3_singletons.html</a>. </p> 
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class TrSettings  
	{
		/** @private */
		private static var instance:TrSettings;
		
		/** @private */
		private static var allowInstantiation:Boolean;
		
		/**
		 * Toggle whether a line break will be added at the beginning and end of a Tr.aceArray() or Tr.aceObject() call.
		 */
		public var arrayAndObjectLinebreaks:Boolean;
		
		/**
		 * Textfield to print the output into
		 */
		public var console:TextField
		
		/**
		 * Toggle whether the output is on or off.
		 */
		public var enabled:Boolean;
		
		/**
		 * An Array of Classes (Class) that you wish the output to ignore.
		 */
		public var ignoreClasses:Array = [];
		
		/**
		 * An Array of Users (String) that you wish the output to ignore.
		 */
		public var ignoreUsers:Array = [];
		
		/**
		 * An Array of Classes (Class) that you wish the output to be restricted to.
		 */
		public var restrictToClasses:Array = [];
		
		/**
		 * An Array of users (Strings) that you wish the output to be restricted to.
		 */
		public var restrictToUsers:Array = [];
		
		/**
		 * Toggle whether the output has line breaks inbetween each trace.
		 */
		public var useLineBreaks:Boolean;
		
		/**
		 * Toggle whether each trace feautures a timestamp (HH:MM:SS:MS).
		 */
		public var useTimeStamp:Boolean;
		
		
		
		/**
		 * Constructor.
		 */
		public function TrSettings():void 
		{
			// if already instantiated, throw an error
			if (!allowInstantiation) throw new Error("Error: Instantiation failed: Use TrSettings.getInstance() instead.");
		}
		
		/**
		 * Returns the instance of this TrSettings Class
		 * 
		 * @return TrSettings 
		 */
		public static function getInstance():TrSettings 
		{
			if (instance == null) 
			{
				allowInstantiation = true;
				instance = new TrSettings();
				allowInstantiation = false;
			}
			
			return instance;
		}
		
	}
	
}