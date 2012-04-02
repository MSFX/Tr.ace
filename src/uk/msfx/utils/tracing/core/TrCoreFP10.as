/**
 * Tr.ace() by MSFX Matt Stuttard Parker
 * Version 1.0
 * 06.09.2011
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
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import uk.msfx.utils.tracing.core.TrCore;
	
	/**
	 * Flash Player 10 version of the core Tr.ace() library.
	 * 
	 * <p>Adds Clipboard support</p>
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class TrCoreFP10 extends TrCore
	{
		/**
		 * Empty Constructor.
		 */
		public function TrCoreFP10():void {	}
		
		
		/**
		 * Function to format and trace to the output console.
		 * 
		 * <p>Extended to provide Clipboard functionality.</p>
		 * 
		 * @param	output 					The output that you wish to trace to the console
		 * @param	user 					The name of the user tracing the output
		 * @param	withinClass				The name of the Class the output is being traced from
		 * @param	startWithLineBreak 		Whether to start the trace with a line break
		 * @param	endWithLineBreak 		Whether to end the trace with a line break
		 */
		override public function out(output:*, user:String, withinClass:*, startWithLineBreak:Boolean = false, endWithLineBreak:Boolean = false):void 
		{
			super.out(output, user, withinClass, startWithLineBreak, endWithLineBreak);
			
			// copy to the clipboard
			if (_copyToClipboard) Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, clipboardText);
		}
		
		
		/**
		 * Whether or not to copy the traces to the clipboard
		 */
		public function get copyToClipboard():Boolean { return settings.copyToClipboard; }
		
		
		/** @private */
		public function set copyToClipboard(value:Boolean):void { settings.copyToClipboard = _copyToClipboard = value; }
		
	}
}