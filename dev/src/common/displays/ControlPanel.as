package common.displays 
{
	import common.Assets;
	import common.tweens.InOutTweener;
	import common.ui.Button;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author beyamor
	 */
	public class ControlPanel extends Display 
	{
		public static const SCREEN_X:int = 600;
		public static const SCREEN_Y:int = 0;
		private var tweener:InOutTweener;
		private var numberOfStandardButtons:int = 0;
		
		private var subDisplay:Display;
		
		public function ControlPanel(parent:World) 
		{
			var backgroundImage:Image = new Image(Assets.IMG_INVENTORYBACKGOUND);			
			super(parent, FP.width, SCREEN_Y, backgroundImage.width, backgroundImage.height);			
			addGraphic(backgroundImage);
			tweener = InOutTweener.forX(parent, this, SCREEN_X, FP.width);
		}
		
		public function slideOn(callback:Function=null):void {
			
			tweener.moveIn(callback);
		}
		
		public function slideOff(callback:Function=null):void {
						
			tweener.moveOut(callback);
		}
		
		// Totally redundant, but it reads better
		public function get thatSlidesOn():ControlPanel { slideOn(); return this; }
		
		public function addStandardButton(label:String, onClick:Function):void {
			
			var image:Image = new Image(Assets.IMG_MAPBUTTONBACKGROUND);
			
			add(Button.description()
					.withImageAndText(image, new Text(label))
					.at(halfWidth - image.width/2, height - 50 - 50 * numberOfStandardButtons)
					.whenClicked(onClick)
					.build());
					
			++numberOfStandardButtons;
		}
	}

}