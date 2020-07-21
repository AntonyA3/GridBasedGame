package entities;

import flixel.FlxSprite;

class Opponent extends FlxSprite
{
	public var min_x:Float = -1000.0;
	public var max_x:Float = 200.0;
	public var min_y:Float = -1000.0;
	public var max_y:Float = 800.0;

	public var illegal = false;
	public var auth_value = 0.1;
	public var pol_value = 0.1;
	override public function new()
	{
		super();
		this.makeGraphic(32, 64);
	}

	override function revive()
	{
		super.revive();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (x > max_x || x < min_x || y < min_y || y > max_y)
		{
			this.kill();
		}
	}
}
