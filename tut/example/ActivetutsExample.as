/**
 * Tr.ace() Example Code by MSFX Matt Stuttard
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
package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import uk.msfx.utils.tracing.fp10.Tr;
	import uk.msfx.utils.tracing.fp10.TrConsole;
	
	/**
	 * Tr.ace() Demo for Activetuts Tutorial
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class ActivetutsExample extends MovieClip 
	{
		// the console
		protected var console:TrConsole;
		
		
		/**
		 * Constructor
		 */
		public function ActivetutsExample() 
		{
			// setup the console
			console = new TrConsole(500, 225);
			console.x = ((stage.stageWidth - console.width) * 0.5);			
			console.y = ((stage.stageHeight- console.height) * 0.5);
			addChild(console);
			
			// create buttons
			setupButton(logo1);
			setupButton(logo2);
			setupButton(logo3);
			setupButton(logo4);
			setupButton(logo5);
			setupButton(logo6);
			
			// init
			Tr.ace("Click the logos around the screen");
		}
		
		/**
		 * Setup the button with handlers etc.
		 * 
		 * @param	mc		The movieclip to be a button
		 */
		protected function setupButton(mc:MovieClip):void 
		{
			mc.addEventListener(MouseEvent.CLICK, mouseEventHandler);
			mc.buttonMode = mc.useHandCursor = true;
		}
		
		/**
		 * Mouse Event Handler
		 * 
		 * @param	e	MouseEvent.CLICK
		 */
		private function mouseEventHandler(e:MouseEvent):void 
		{
			switch (e.currentTarget.name) 
			{
				case "logo1":
					Tr.ace("TutsPlus!");
				break;
				
				case "logo2":
					Tr.ace("Get Fit, Get Activetuts+!");
				break;
				
				case "logo3":
					Tr.ace("TutsPlus!");
				break;
				
				case "logo4":
					// array demo
					Tr.ace("Use Tr.ace() to print out arrays and objects...");
					var array:Array = ["Activetuts+!", "Learn Flash!", "Learn Unity!", "Learn HTML5!", "Learn Silverlight!"];
					Tr.aceArray(array);
				break;
				
				case "logo5":
					Tr.ace("Find Love, Go Premium!");
				break;
				
				case "logo6":
					// array demo
					Tr.ace("Use Tr.ace() to print out a range of different objects on one line...");
					Tr.aceMulti("", null, "String", 123, true, 456.789, ["a", "r", "r", "a", "y"], { ob: "ject" } );
				break;
			}
		}
		
	}
}