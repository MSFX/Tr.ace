package 
{
	import com.gskinner.performance.PerformanceTest;
	import com.gskinner.performance.TestSuite;
	import com.gskinner.performance.TextLog;
	import com.gskinner.performance.XMLLog;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import tests.WithinClassTest;
	
	/**
	 * Testing Suite built using Grant Skinners Performance library for Tr.ace().
	 * 
	 * http://gskinner.com/blog/archives/2010/02/performancetest.html
	 * 
	 * @author MSFX Matt Stuttard
	 */
	public class PerformanceTestMain extends MovieClip
	{
		public var outFld:TextField;
		public var loopsMultiple:Number = 1;
		
		
		public function PerformanceTestMain()
		{
			PerformanceTest.getInstance().delay = 1000;
			
			outFld.text = "Running tests on " + Capabilities.version + " " + (Capabilities.isDebugger ? "DEBUG" : "RELEASE") + " with loopsMultiple=" + loopsMultiple + "...\n";
			new TextLog().out = out;
			new XMLLog().out = out2;
			
			queueTest(new WithinClassTest());
		}
		
		protected function queueTest(test:*):void 
		{
			if ("loops" in test) 
			{
				test.loops = test.loops*loopsMultiple|0;
			} 
			else 
			{
				out("* Test: "+test.name+" does not have a loops property.");
			}
			
			PerformanceTest.queue(test);
		}
		
		protected function out(str:*):void 
		{
			outFld.appendText(String(str)+"\n");
			outFld.scrollV = outFld.maxScrollV;
		}
		
		protected function out2(str:*):void 
		{
			outFld.appendText("\n"+String(str)+"\n");
			outFld.scrollV = outFld.maxScrollV;
		}
		
		protected function handleTestComplete(evt:Event):void 
		{
			var test:TestSuite = evt.target as TestSuite;
			trace(test.toXML().toXMLString());
		}
	}
	
}