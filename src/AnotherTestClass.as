/**
 * Tr.ace() Example Code by MSFX Matt Stuttard
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
package 
{
	import uk.msfx.utils.tracing.Tr;
	
	/**
	 * Another Test Class to demonstrate use of Tr.ace()
	 * @author MSFX
	 */
	public class AnotherTestClass 
	{
		/**
		 * Constructor.
		 */
		public function AnotherTestClass():void 
		{
			// trace from 'DEFAULT'
			Tr.ace("trace for all to read", Tr.DEFAULT, AnotherTestClass);
			
			// trace from 'MATT'
			Tr.ace("matt's trace", Tr.MATT, AnotherTestClass);
		}
		
	}
}