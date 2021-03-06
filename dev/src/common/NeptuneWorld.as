package common 
{
	import common.displays.Display;
	import common.displays.DisplayStack;
	import common.ui.Cursor;
	import net.flashpunk.World;
	
	/**
	 * Stuff common to all worlds in our game.
	 * @author beyamor
	 */
	public class NeptuneWorld extends World 
	{
		private var	cursor:Cursor;
		public var	displays:DisplayStack = new DisplayStack;
		
		public function NeptuneWorld() 
		{
			
		}
		
		override public function update():void 
		{
			displays.update();
			super.update();
		}
		
		override public function render():void 
		{
			displays.render();
			super.render();
		}
		
		public function removeCursor():void {
			
			if (cursor) remove(cursor);
		}
		
		public function setCursor(newCursor:Cursor):void {
			
			if (cursor) remove(cursor);
			cursor = newCursor;
			cursor.x = mouseX;
			cursor.y = mouseY;
			cursor.show();
			add(cursor);
		}
		
		override public function end():void 
		{
			super.end();
			displays.end();
			Cursor.hideActiveIfThis(cursor);
		}
	}

}