/**
 * Tr.ace() by MSFX Matt Stuttard Parker
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
package uk.msfx.utils.tracing.core
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	
	/**
	 * Tr.ace Console Core.
	 * 
	 * @author MSFX Matt Stuttard Parker
	 */
	public class TrConsoleCore extends Sprite 
	{
		/**
		 * Minimum Width of the console.
		 */
		protected const MINIMUM_WIDTH:int = 450;
		
		/**
		 * Minimum Height of the console.
		 */
		protected const MINIMUM_HEIGHT:int = 200;
		
		
		/** @private **/
		protected var _textfield:TrTextField;
		/** @private **/
		protected var _backgroundColour:uint = 0xFFFFFF;
		/** @private **/
		protected var _strokeColour:uint = 0xBBBBBB;
		/** @private **/
		protected var _autoscroll:Boolean = true;
		/** @private **/
		protected var _showing:Boolean = true;
		
		/** @private **/
		protected var headerButton:Sprite;
		/** @private **/
		protected var clearButton:Sprite;
		/** @private **/
		protected var saveButton:Sprite;
		/** @private **/
		protected var clipboardButton:Sprite;
		/** @private **/
		protected var minimizeButton:Sprite;
		/** @private **/
		protected var resizeButton:Sprite;
		/** @private **/
		protected var closeButton:Sprite;
		/** @private **/
		protected var spacing:uint = 10;
		/** @private **/
		protected var mousePositionDiffX:int = 0;
		/** @private **/
		protected var mousePositionDiffY:int = 0;
		/** @private **/
		protected var background:Sprite;
		/** @private **/
		protected var resizing:Boolean;
		/** @private **/
		protected var saveAndClipboard:Boolean;
		/** @private **/
		protected var transparentOnHide:Boolean;
		/** @private **/
		protected var transparentOnHideAmount:Number = 0.5;
		
		
		/**
		 * Constructor.
		 * 
		 * @param	width					The width of the console.
		 * @param	height					The height of the console.
		 * @param	saveAndClipboard		OPTIONAL Whether to have the Clipboard and Save buttons.
		 * @param	transparentOnHide		OPTIONAL Whether to make the console transparent when minimizing.
		 */
		public function TrConsoleCore(width:int = 600, height:int = 200, saveAndClipboard:Boolean = true, transparentOnHide:Boolean = false) 
		{
			this.saveAndClipboard = saveAndClipboard;
			this.transparentOnHide = transparentOnHide;
			
			// setup the labels and buttons etc
			setupUI();
			
			// draw the background
			drawBackground(Math.max(MINIMUM_WIDTH, width), Math.max(MINIMUM_HEIGHT, height));
			
			// listen for adding to stage
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		/**
		 * Hide the console, leaving only the title bar visible.
		 */
		public function hide():void 
		{
			_showing = resizeButton.visible = _textfield.visible = false;
			drawBackground(width - 1, (spacing * 2) + headerButton.height, false, transparentOnHide); // -1 for stroke
		}
		
		/**
		 * Hide the console, leaving only the title bar visible.
		 */
		public function show():void 
		{
			_showing = resizeButton.visible = _textfield.visible = true;
			drawBackground(width - 1, resizeButton.y + (spacing * 0.5) + resizeButton.height); // -1 for stroke
		}
		
		/**
		 * Setup the UI components for the console.
		 * @private
		 */
		protected function setupUI():void 
		{
			// background
			background = new Sprite();
			background.name = "background";
			addChild(background);
			
			var label:TextField;
			
			// header
			headerButton = new Sprite();
			headerButton.buttonMode = headerButton.useHandCursor = true;
			headerButton.mouseChildren = false;
			headerButton.x = headerButton.y = spacing;
			headerButton.name = "headerButton";
			
			// header label
			label = new TextField();
			label.htmlText = "<p><font color=\"#0080aa\">Tr</font>.ace(<font color=\"#a31515\">\"Version 2.0\"</font><font color=\"#000000\">)</font></p>";
			label.width = label.textWidth + 5;
			label.height = label.textHeight + 5;
			headerButton.addChild(label);
			
			
			// setup the console textfield
			_textfield = new TrTextField();
			_textfield.x = spacing;
			_textfield.y = headerButton.y + headerButton.height + spacing;
			_textfield.borderColor = 0xEEEEEE;
			addChild(_textfield);
			
			// clear
			clearButton = new Sprite();
			clearButton.buttonMode = clearButton.useHandCursor = true;
			clearButton.mouseChildren = false;
			clearButton.y = spacing;
			clearButton.name = "clearButton";
			
			// clear label
			label = new TextField();
			label.text = "Clear";
			label.width = label.textWidth + 5;
			label.height = label.textHeight + 5;
			label.textColor = 0xBBBBBB;
			clearButton.addChild(label);
			
			// save and clipboard buttons - removed for FP9 branch
			if (saveAndClipboard)
			{
				// save
				saveButton = new Sprite();
				saveButton.buttonMode = saveButton.useHandCursor = true;
				saveButton.mouseChildren = false;
				saveButton.y = spacing;
				saveButton.name = "saveButton";
				
				// save label
				label = new TextField();
				label.text = "Save";
				label.width = label.textWidth + 5;
				label.height = label.textHeight + 5;
				label.textColor = 0xBBBBBB;
				saveButton.addChild(label);
				
				// clipboard
				clipboardButton = new Sprite();
				clipboardButton.buttonMode = clipboardButton.useHandCursor = true;
				clipboardButton.mouseChildren = false;
				clipboardButton.y = spacing;
				clipboardButton.name = "clipboardButton";
				
				// clipboard label
				label = new TextField();
				label.text = "Clipboard";
				label.width = label.textWidth + 5;
				label.height = label.textHeight + 5;
				label.textColor = 0xBBBBBB;
				clipboardButton.addChild(label);
			}
			
			// show or hide
			minimizeButton = new Sprite();
			minimizeButton.buttonMode = minimizeButton.useHandCursor = true;
			minimizeButton.mouseChildren = false;
			minimizeButton.y = spacing;
			minimizeButton.name = "minimizeButton";
			
			// show or hide label
			label = new TextField();
			label.text = "Show / Hide";
			label.width = label.textWidth + 5;
			label.height = label.textHeight + 5;
			label.textColor = 0xBBBBBB;
			minimizeButton.addChild(label);
			
			// close
			closeButton = new Sprite();
			closeButton.buttonMode = closeButton.useHandCursor = true;
			closeButton.mouseChildren = false;
			closeButton.y = spacing;
			closeButton.name = "closeButton";
			
			// close label
			label = new TextField();
			label.text = "Close";
			label.width = label.textWidth + 5;
			label.height = label.textHeight + 5;
			label.textColor = 0xBBBBBB;
			closeButton.addChild(label);
			
			// resize button
			resizeButton = new Sprite();
			resizeButton.buttonMode = resizeButton.useHandCursor = true;
			resizeButton.mouseChildren = false;
			resizeButton.graphics.beginFill(0xFFFFFF);
			resizeButton.graphics.drawRect(0, 0, spacing, spacing);
			resizeButton.graphics.endFill();
			resizeButton.graphics.lineStyle(1, 0xBBBBBB, 1, true);
			resizeButton.graphics.moveTo(0, spacing);
			resizeButton.graphics.lineTo(spacing, 0);
			resizeButton.graphics.moveTo(Math.floor(spacing * .4), spacing);
			resizeButton.graphics.lineTo(spacing, Math.floor(spacing * .4));
			resizeButton.graphics.moveTo(Math.floor(spacing * .8), spacing);
			resizeButton.graphics.lineTo(spacing, Math.floor(spacing * .8));
			resizeButton.graphics.endFill();
			resizeButton.name = "resizeButton";
			
			// add buttons
			addChild(headerButton);
			addChild(clearButton);
			
			if (saveAndClipboard)
			{
				addChild(clipboardButton);
				addChild(saveButton);
			}
			
			addChild(minimizeButton);
			addChild(closeButton);
			addChild(resizeButton);
		}
		
		/**
		 * Draw the background and then call resize handler to reposition components (default).
		 * @private
		 * 
		 * @param	width					Width of the background to draw
		 * @param	height					Height of the background to draw
		 * @param	resizeAfter				OPTIONAL Whether to resize after drawing background.
		 * @param	transparentOnHide		OPTIONAL Whether to make the console transparent when minimizing.
		 */
		protected function drawBackground(width:int, height:int, resizeAfter:Boolean = true, transparentOnHide:Boolean = false):void 
		{
			// clear and redraw background
			background.graphics.clear();
			background.graphics.lineStyle(1, _strokeColour, 1, true);
			background.graphics.beginFill(_backgroundColour, (transparentOnHide)? transparentOnHideAmount : 1);
			background.graphics.drawRoundRect(0, 0, width, height, 10);
			background.graphics.endFill();
			
			// resize components
			if (resizeAfter) resizeHandler();
		}
		
		/**
		 * Resize Handler.
		 * @private
		 */
		protected function resizeHandler():void 
		{
			// buttons
			if (saveAndClipboard)
			{
				closeButton.x = width - spacing - closeButton.width;
				minimizeButton.x = closeButton.x - spacing - minimizeButton.width;
				saveButton.x = minimizeButton.x - spacing - saveButton.width;
				clipboardButton.x = saveButton.x - spacing - clipboardButton.width;
				clearButton.x = clipboardButton.x - spacing - clearButton.width;
			}
			else
			{
				closeButton.x = width - spacing - closeButton.width;
				minimizeButton.x = closeButton.x - spacing - minimizeButton.width;
				clearButton.x = minimizeButton.x - spacing - clearButton.width;
			}
			
			resizeButton.x = width - (spacing * 0.5) - resizeButton.width;
			resizeButton.y = height - (spacing * 0.5)  - resizeButton.height;
			
			// console
			_textfield.width = width - (spacing * 2);
			_textfield.height = height - (spacing * 3) - headerButton.height;
		}
		
		
		/**
		 * Added To Stage Event Handler.
		 * @private
		 * 
		 * @param	e	Event.ADDED_TO_STAGE
		 */
		protected function added(e:Event):void 
		{
			// listen for removal
			removeEventListener(Event.ADDED_TO_STAGE, added);
			addEventListener(Event.REMOVED_FROM_STAGE, removed);
			
			// add handlers
			headerButton.addEventListener(MouseEvent.CLICK, mouseEventHandler);
			clearButton.addEventListener(MouseEvent.CLICK, mouseEventHandler);
			minimizeButton.addEventListener(MouseEvent.CLICK, mouseEventHandler);
			closeButton.addEventListener(MouseEvent.CLICK, mouseEventHandler);
			
			if (saveAndClipboard)
			{
				clipboardButton.addEventListener(MouseEvent.CLICK, mouseEventHandler);
				saveButton.addEventListener(MouseEvent.CLICK, mouseEventHandler);
			}
			
			resizeButton.addEventListener(MouseEvent.MOUSE_DOWN, resizeAndRepositionMouseEventHandler);
			background.addEventListener(MouseEvent.MOUSE_DOWN, resizeAndRepositionMouseEventHandler);
			
			if (_autoscroll) _textfield.addEventListener(Event.CHANGE, textfieldChangeEventHandler);
		}
		
		/**
		 * Removed From Stage Event Handler.
		 * @private
		 * 
		 * @param	e	Event.REMOVED_FROM_STAGE
		 */
		protected function removed(e:Event = null):void 
		{
			// listen for re-adding
			removeEventListener(Event.REMOVED_FROM_STAGE, removed);
			addEventListener(Event.ADDED_TO_STAGE, added);
			
			// remove handlers
			headerButton.removeEventListener(MouseEvent.CLICK, mouseEventHandler);
			clearButton.removeEventListener(MouseEvent.CLICK, mouseEventHandler);
			minimizeButton.removeEventListener(MouseEvent.CLICK, mouseEventHandler);
			closeButton.removeEventListener(MouseEvent.CLICK, mouseEventHandler);
			
			if (saveAndClipboard)
			{
				clipboardButton.removeEventListener(MouseEvent.CLICK, mouseEventHandler);
				saveButton.removeEventListener(MouseEvent.CLICK, mouseEventHandler);
			}
			
			resizeButton.removeEventListener(MouseEvent.MOUSE_DOWN, resizeAndRepositionMouseEventHandler);
			background.removeEventListener(MouseEvent.MOUSE_DOWN, resizeAndRepositionMouseEventHandler);
			
			if (_autoscroll) _textfield.removeEventListener(Event.CHANGE, textfieldChangeEventHandler);
		}
		
		/**
		 * Mouse Event Handler for Resizing and Repositioning the "Console Window".
		 * @private
		 * 
		 * @param	e	MouseEvent.MOUSE_DOWN
		 * @param	e	MouseEvent.MOUSE_MOVE
		 * @param	e	MouseEvent.MOUSE_UP
		 */
		protected function resizeAndRepositionMouseEventHandler(e:MouseEvent):void 
		{
			switch (e.type) 
			{
				case MouseEvent.MOUSE_DOWN:
					
					// determine source of event
					if (e.currentTarget.name == "resizeButton")
					{
						resizing = true;
						mousePositionDiffX = resizeButton.mouseX;
						mousePositionDiffY = resizeButton.mouseY;
					}
					else // e.currentTarget = background
					{
						resizing = false;
						mousePositionDiffX = this.mouseX;
						mousePositionDiffY = this.mouseY;
					}
					
					// remove handlers
					resizeButton.removeEventListener(MouseEvent.MOUSE_DOWN, resizeAndRepositionMouseEventHandler);
					background.removeEventListener(MouseEvent.MOUSE_DOWN, resizeAndRepositionMouseEventHandler);
					
					// add handlers
					stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveEventHandler);
					stage.addEventListener(MouseEvent.MOUSE_MOVE, resizeAndRepositionMouseEventHandler);
					stage.addEventListener(MouseEvent.MOUSE_UP, resizeAndRepositionMouseEventHandler);
					
				break;
				
				case MouseEvent.MOUSE_UP:
					
					// remove handlers
					stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveEventHandler);
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, resizeAndRepositionMouseEventHandler);
					stage.removeEventListener(MouseEvent.MOUSE_UP, resizeAndRepositionMouseEventHandler);
					
					// add handlers
					resizeButton.addEventListener(MouseEvent.MOUSE_DOWN, resizeAndRepositionMouseEventHandler);
					background.addEventListener(MouseEvent.MOUSE_DOWN, resizeAndRepositionMouseEventHandler);
					
				break;
				
				case MouseEvent.MOUSE_MOVE:
					
					// resize the "console window"
					if (resizing)
					{
						// reposition the resize button
						resizeButton.x = Math.max(MINIMUM_WIDTH - resizeButton.width - (spacing * 0.5) - 0, this.mouseX - mousePositionDiffX); // -1 for stroke
						resizeButton.y = Math.max(MINIMUM_HEIGHT - resizeButton.height - (spacing * 0.5) - 0, this.mouseY - mousePositionDiffY); // -1 for stroke
						
						// and then redraw the background to take into account new resize button position
						drawBackground(resizeButton.x + (spacing * 0.5) + resizeButton.width, resizeButton.y + (spacing * 0.5) + resizeButton.height);
					}
					else // or just reposition on the stage
					{
						this.x = stage.mouseX - mousePositionDiffX;
						this.y = stage.mouseY - mousePositionDiffY;
					}
					
				break;
			}
		}
		
		/**
		 * Mouse Leave Event Handler.
		 * @private
		 * 
		 * <p>Mimicks the behaviour of MouseEvent.MOUSE_UP when user leaves the stage.</p>
		 * 
		 * @param	e	Event.MOUSE_LEAVE
		 */
		protected function mouseLeaveEventHandler(e:Event):void 
		{
			// remove handlers
			stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveEventHandler);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, resizeAndRepositionMouseEventHandler);
			stage.removeEventListener(MouseEvent.MOUSE_UP, resizeAndRepositionMouseEventHandler);
			
			// add handlers
			resizeButton.addEventListener(MouseEvent.MOUSE_DOWN, resizeAndRepositionMouseEventHandler);
			background.addEventListener(MouseEvent.MOUSE_DOWN, resizeAndRepositionMouseEventHandler);
		}
		
		/**
		 * TextField Change Event Handler.
		 * @private
		 * 
		 * @param	e	Event.CHANGE
		 */
		protected function textfieldChangeEventHandler(e:Event):void 
		{
			// scroll to the bottom of the textfield
			_textfield.scrollV = _textfield.numLines;
		}
		
		/**
		 * Mouse Event Handler.
		 * @private
		 * 
		 * <p>Default behaviours for Minimize, Close and clicking Header.</p>
		 * 
		 * <p>Overridden to provide behaviours for clear, clipboard and save.</p>
		 * 
		 * @param	e	MouseEvent.CLICK
		 */
		protected function mouseEventHandler(e:MouseEvent):void 
		{		
			switch (e.currentTarget.name) 
			{
				case "minimizeButton":
					(_showing)? hide() : show();
				break;
				
				case "headerButton":
					navigateToURL(new URLRequest("http://msfx.co.uk/category/open-source/"), "_blank");
				break;
				
				case "closeButton":
					parent.removeChild(this);
				break;
			}
		}
		
		
		/**
		 * Whether the console is showing or in minimized format.
		 */
		public function get showing():Boolean { return _showing; }
		
		
		/** @private **/
		public function get textfield():TrTextField { return _textfield; }
		
		/** @private **/
		public function get autoscroll():Boolean { return _autoscroll; }
		
		
		/**
		 * Whether the textfield will autoscroll when new traces made.
		 */
		public function set autoscroll(value:Boolean):void 
		{ 
			_autoscroll = value; 
			
			// add / remove change handler from textfield
			if (_autoscroll)
			{
				_textfield.addEventListener(Event.CHANGE, textfieldChangeEventHandler);
			}
			else
			{
				_textfield.removeEventListener(Event.CHANGE, textfieldChangeEventHandler);
			}
		}
		
		/**
		 * The textfield to ouput the traces to.
		 */
		public function set textfield(value:TrTextField):void { _textfield = value; }
		
		/**
		 * The background colour for the console.
		 */
		public function set backgroundColour(value:uint):void 
		{
			_backgroundColour = value;
			drawBackground(width - 1, resizeButton.y + (spacing * 0.5) + resizeButton.height); // -1 for stroke
		}
		
		/**
		 * The stroke colour for the console.
		 */
		public function set strokeColour(value:uint):void 
		{
			_strokeColour = value;
			drawBackground(width - 1, resizeButton.y + (spacing * 0.5) + resizeButton.height); // -1 for stroke
		}
		
		
		/** @private **/
		override public function get height():Number { return super.height; }
		
		/** @private **/
		override public function get width():Number { return super.width; }
		
		
		/**
		 * @private
		 * Redraw background if resized
		 */
		override public function set height(value:Number):void 
		{
			drawBackground(width, value);
		}
		
		/**
		 * @private
		 * Redraw background if resized
		 */
		override public function set width(value:Number):void 
		{
			drawBackground(value, height);
		}
		
		
	}
}