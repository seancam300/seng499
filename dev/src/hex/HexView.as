package hex 
{
    import flash.geom.Point;
	import model.Game;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import flash.geom.Rectangle;
	import common.ui.Button;
	import net.flashpunk.graphics.Image;
	import map.MapView;
	import common.Assets;
	import hex.controllers.HexController;
	import hex.controllers.ControllerFactory;
	import hex.math.SpaceConverter;
	
	/**
	 * ...
	 * @author beyamor
	 */
	public class HexView extends World 
	{
		private var grid:HexGrid;
		private var scrollCamera:ScrollCamera;
		private var returningToMap:Boolean = false;
		private var game:Game;
		public var  controller:HexController;
		
		public function HexView(game:Game, mapX:Number, mapY:Number)
		{			
			this.game = game;

			controller = (new ControllerFactory).createFor(game, this);

			// the hex grid bounds are 100% arbitrary, so deal with it
			const WIDTH:uint        = GameConstants.HEX_VIEW_WIDTH;
			const HEIGHT:uint       = GameConstants.HEX_VIEW_HEIGHT;
			const HEX_RADIUS:uint   = GameConstants.HEX_RADIUS;

			var converter:SpaceConverter = SpaceConverter.getCanonical();

			var hexCoords:Point         = converter.getConvertedPoint(mapX, mapY);
			var initialCameraX:Number    = hexCoords.x - FP.width/2;
			var initialCameraY:Number    = hexCoords.y - FP.height/2;

			FP.camera.x = initialCameraX;
			FP.camera.y = initialCameraY;

			scrollCamera = new ScrollCamera(350, 0, 0, WIDTH, HEIGHT);

                        var factory:HexFactory = new HexFactory(new Cartographer(game.data), game.data);
			grid = new HexGrid(factory, this, HEX_RADIUS, WIDTH, HEIGHT);

			add(Button.description()
						.fixedAt(FP.width - 50, 30)
						.withDepth(-1)
						.withImage(new Image(Assets.IMG_MAP_FROM_HEX_BUTTON))
						.whenClicked(function():void {

							returningToMap = true;
						})
						.build());
		}

		override public function update():void 
		{
			super.update();

			scrollCamera.update();
			grid.fillView();

			// This is kinda junk.
			if (returningToMap) {

				FP.world = new MapView(game);
			}

			else {
			
				if (Input.mousePressed) {
					
					for each (var tile:HexTile in grid.tilesOnScreen) {

						if (tile.containsPoint(FP.world.mouseX, FP.world.mouseY)) {
							
							controller.hexSelected(tile);
						}
					}
				}
			}
		}
	}

}
