package 
{
	import common.Assets;
	import common.displays.InstructionDisplay;
	import common.displays.Popup;
	import events.displays.SeasonEventAnnouncement;
	import events.instruments.BuyFirstNode;
	import events.world.SeasonalEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.setTimeout;
	import hex.HexView;
	import map.MapView;
	import model.Game;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import store.StoreView;
	import time.Seasons;
	import title.TitleView;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class Main extends Engine 
	{
		private var game:Game;
		public function Main():void 
		{
			super(800, 600);
		}
		
		override public function init():void 
		{
			super.init();
			
			initModel();
			initSound();
			
			// You don't need it
			//FP.console.enable();
			
			Input.define("debug-hex-start",		Key.DIGIT_0);
			Input.define("debug-map-start",		Key.DIGIT_1);
			Input.define("debug-store-start",	Key.DIGIT_2);
			Input.define("hex-scroll-up",		Key.W, Key.UP);
			Input.define("hex-scroll-down",		Key.S, Key.DOWN);
			Input.define("hex-scroll-left",		Key.A, Key.LEFT);
			Input.define("hex-scroll-right",	Key.D, Key.RIGHT);
			
			FP.world = new TitleView(game);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed("debug-hex-start"))			FP.world = new HexView(game, 0, 0);
			else if (Input.pressed("debug-map-start"))		FP.world = new MapView(game);
			else if (Input.pressed("debug-store-start"))	FP.world = new StoreView(game);
		}
		
		private function initModel():void
		{
			game = new Game();	
			
			/*var chince:SeasonalEvent = new SeasonalEvent(
				Seasons.SUMMER, 
				500, 
				"The government of Canada has recognized that\n"
				+ "the NEPTUNE Canada project\n" 
				+ "is important for science!\n"
				+ "They have decided to give you\n"
				+ "$500 in the coming season to purchase a Node.\n"
				+ "Remember! You need a Node before you can attach\n"
				+ "instruments to collect interesting data!");*/
				
			var chince:SeasonalEvent = new BuyFirstNode();
			
			game.state.pushEventDisplay(new SeasonEventAnnouncement(chince));
			game.data.gameEvents.push(chince);
		}

		private function initSound():void
		{
			var sound:Sound = (new Assets.SOUND_NEPTUNE) as Sound;
			sound.play();
			sound.addEventListener(Event.SOUND_COMPLETE, replaySound);
			setTimeout(replaySound, sound.length);
		}
		
		private function replaySound():void
		{
			var sound:Sound = (new Assets.SOUND_NEPTUNE) as Sound;
			sound.play();
			setTimeout(replaySound, sound.length);
		}
}
	
}
