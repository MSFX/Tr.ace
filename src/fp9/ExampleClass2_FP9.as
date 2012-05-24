/**
 * Tr.ace() Example Code by MSFX Matt Stuttard
 * Version 2.0
 * 24.05.2012
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
	import uk.msfx.utils.tracing.fp9.Tr;
	import uk.msfx.utils.tracing.users.TrUsers;
	
	/**
	 * Another Test Class to demonstrate use of Tr.ace()
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class ExampleClass2_FP9 
	{
		/**
		 * Constructor.
		 */
		public function ExampleClass2_FP9():void 
		{
			// trace from 'DEFAULT'
			Tr.ace("Trace for all to read", TrUsers.DEFAULT, Object(this).constructor);
			
			// trace from 'MSFX'
			Tr.ace("Matt's trace", TrUsers.MSFX, Object(this).constructor);
		}
		
	}
}