package entities.grid;

import flixel.FlxBasic;
import flixel.group.FlxGroup;
import openfl.geom.Point;

class Grid {
    @:isVar
    public var data(get, set):Array<Array<Int>>;
    @:isVar
    public var cell_width(get, set):Int;
    @:isVar
    public var cell_height_spacing(get, set):Int;
	@:isVar
    public var cell_height(get, set):Int;
    @:isVar
    public var cell_width_spacing(get, set):Int;
    


    public function new() {
        
    }
    function get_cell_width():Int {
        return this.cell_width;
    }
    
    function set_cell_width(cell_width:Int):Int {
        return this.cell_width = cell_width;
    }
	function get_data():Array<Array<Int>> {
        return this.data;
    }
   
    
    function get_cell_height():Int {
        return this.cell_height;
    }
    
    function set_cell_height(cell_height:Int):Int {
        return this.cell_height = cell_height;
    }

    
    function get_cell_width_spacing():Int {
        return this.cell_width_spacing;
    }
    
    function set_cell_width_spacing(cell_width_spacing:Int):Int {
        return this.cell_width_spacing = cell_width_spacing;
    }
    
    
    function get_cell_height_spacing():Int {
        return cell_height_spacing;
    }
    
    function set_cell_height_spacing(cell_height_spacing:Int):Int {
        return this.cell_height_spacing = cell_height_spacing;
    }
    
	function set_data(data:Array<Array<Int>>):Array<Array<Int>> {
        return this.data = data;
        
    }

    public function world_to_grid(xy:Point):Point {
        var px = xy.x;
        px = Math.floor(px / (cell_width + cell_width_spacing));
        var py = xy.y;
        py = Math.floor(py / (cell_height + cell_height_spacing));
        return new Point(px, py);
    }

    public function valueAt(x:Int, y:Int) {
        if(x >= 0 && y >=0 && y< data.length && x < data[0].length){
			return this.data[y][x];
        }
        return - 1;
    
    }


    
}