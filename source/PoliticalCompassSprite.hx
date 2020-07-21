import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxRect;
import flixel.util.FlxColor;

class PoliticalCompassSprite extends FlxSpriteGroup
{
	private var point:FlxSprite;
	private var area:FlxSprite;

	@:isVar
	public var x_value(get, set):Float = 0.0;

	function get_x_value():Float
	{
		return x_value;
	}

	function set_x_value(x_value:Float):Float
	{
		return this.x_value = x_value;
	}

	@:isVar
	public var y_value(get, set):Float = 0.0;

	function get_y_value():Float
	{
		return this.y_value;
	}

	function set_y_value(y_value:Float):Float
	{
		return this.y_value = y_value;
	}

	public var min_x_value:Float = -100;
	public var max_x_value:Float = 100;

	public var min_y_value:Float = -100;
	public var max_y_value:Float = 100;

	public function new()
	{
		super();
		this.area = new FlxSprite();
		this.area.loadGraphic(AssetPaths.compass_texture__png, false, 64, 64, false);

		this.area.x = 16;
		this.area.y = 16;
		this.point = new FlxSprite();
		this.point.makeGraphic(10, 10);
		this.allowCollisions = FlxObject.NONE;

		this.x_value = 0;

		add(area);
		add(point);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		point.x = area.x + (max_x_value - x_value) / (max_x_value - min_x_value) * area.width - 5.0;
		point.y = area.y + (max_y_value - y_value) / (max_y_value - min_y_value) * area.height - 5.0;
	}
}
