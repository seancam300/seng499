package hex {

    import flash.display.Graphics;
    import flash.display.Shape;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import net.flashpunk.Graphic;
    import net.flashpunk.FP;

    public class HexSprite extends Graphic {

        private var _buffer:BitmapData;
        private var _bufferRect:Rectangle;
        private var _bitmap:Bitmap          = new Bitmap;
        private var _color:uint;

        private var _radius:Number;
        private function get radius():Number { return _radius; }

        private var _vertices:Vector.<Point>;
        private function get vertices():Vector.<Point> { return _vertices; }

        private function get centerX():Number { return radius; }
        private function get centerY():Number { return radius; }

        public function HexSprite(radius:Number, color:Number) {

            _radius = radius;
            _color = color;

            // Center the hexagon
            x = -centerX;
            y = -centerY;

            buildVertexList();

            createBuffer();
            renderToBuffer();
        }

        private function createBuffer():void {

            _buffer             = new BitmapData(2 * radius, 2 * radius, true, 0);
            _bufferRect         = _buffer.rect;
            _bitmap.bitmapData  = _buffer;
        }

        private function renderToBuffer():void {

            var vertexIndex:uint;
            var shape:Shape         = new Shape;
            var graphics:Graphics   = shape.graphics;

            graphics.clear();
            graphics.beginFill(_color);

            graphics.moveTo(vertices[0].x, vertices[0].y);
            for (vertexIndex = 1; vertexIndex < 6; ++vertexIndex)
                graphics.lineTo(vertices[vertexIndex].x, vertices[vertexIndex].y);
            graphics.lineTo(vertices[0].x, vertices[0].y);

            graphics.endFill();

            _buffer.draw(shape);
        }

        private function buildVertexList():void {

                var theta:Number;
                _vertices = new Vector.<Point>;

                for (var vertexIndex:uint = 0; vertexIndex < 6; ++vertexIndex) {

                        theta = vertexIndex * (Math.PI * 2 / 6);

                        _vertices.push(new Point(
                                                centerX + radius * Math.cos(theta),
                                                centerY + radius * Math.sin(theta)));
                }
        }
  
        override public function render(target:BitmapData, point:Point, camera:Point):void {
            
            // determine drawing location
            _point.x = point.x + x - camera.x * scrollX;
            _point.y = point.y + y - camera.y * scrollY;
            
            // render without transformation
            target.copyPixels(_buffer, _bufferRect, _point, null, null, true);
        }
    }
}
