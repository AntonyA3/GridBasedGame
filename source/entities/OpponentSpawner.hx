package entities;

import js.html.Animation;
import flixel.FlxBasic;
import flixel.util.FlxTimer;

class OpponentSpawner extends FlxBasic
{

	private var spawn_timer:Float = 5.0;
	public var spawn_interval:Float = 5.0;
	public var spawn = false;
	public var object_start_x = 0.0;
	public var object_start_y = 0.0;
	public var object_x_velocity = 0.0;
	public var object_y_velocity = 0.0;
	public var object_min_x = 0.0;
	public var object_max_x = 0.0;
	public var object_min_y = 0.0;
	public var object_max_y = 0.0;
	

	private var active_time = 0.0;
	public var object_x_velocity_event:Array<Float> = new Array<Float>();
	public var object_y_velocity_event:Array<Float> = new Array<Float>();
	public var spawn_interval_events: Array<Float> = new Array<Float>();


	private var stage_1_event_time = 10.0;
	private var stage_1_event_complete = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		spawn_timer -= elapsed;
		if (spawn_timer < 0)
		{
			spawn = true;
			spawn_timer = spawn_interval + spawn_timer;
		}
		else
		{
			spawn = false;
		}
		this.object_x_velocity *= 1.5;
		this.object_x_velocity *= 1.5;
		
	}
}
