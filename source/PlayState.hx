package;

import flixel.math.FlxRandom;
import flixel.group.FlxGroup.FlxTypedGroup;
import data.LevelData;
import data.OpponentSpawnerData;
import entities.Opponent;
import entities.OpponentSpawner;
import entities.OpponentSpriteCollection;
import entities.Player;
import entities.grid.Grid;
import entities.grid.GridSprite;
import entities.grid.GridSpriteCollection;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import generators.GridGenerator;
import haxe.Json;
import haxe.ds.List;
import lime.utils.Assets;
import openfl.geom.Point;

class PlayState extends FlxState
{
	var player:Player;
	var grid:Grid;
	var grid_sprite_collection:GridSpriteCollection;
	var oppenent_spawner_collection:Array<OpponentSpawner>;
	var opponent_collection:OpponentSpriteCollection;
	var stamina_bar:FlxBar;
	var pol_bar:FlxBar;
	var auth_bar:FlxBar;
	var game_over:Bool = false;
	var just_game_over:Bool = false;
	var political_compass:PoliticalCompassSprite;
	var timer:Float = 5.0;
	override public function create()
	{
		super.create();
		var level:LevelData = Json.parse(Assets.getText(AssetPaths.level_1_data__json));
		grid = new GridGenerator().toGrid(level.grid);
		player = new Player();
		player.x_move_increment = grid.cell_width + grid.cell_width_spacing;
		player.y_move_increment = grid.cell_height + grid.cell_height_spacing;
		player.makeGraphic(grid.cell_width, grid.cell_height, FlxColor.RED);
		player.x = level.player.x;
		player.y = level.player.y;

		grid_sprite_collection = new GridSpriteCollection();
		for (y in 0...grid.data.length)
		{
			for (x in 0...grid.data[y].length)
			{
				if (grid.data[y][x] == 1)
				{
					var grid_sprite = new GridSprite();
					grid_sprite.x = x * (grid.cell_width + grid.cell_width_spacing);
					grid_sprite.y = y * (grid.cell_height + grid.cell_height_spacing);
					grid_sprite.makeGraphic(grid.cell_width, grid.cell_height, FlxColor.ORANGE);
					grid_sprite_collection.add(grid_sprite);
				}
			}
		}

		this.oppenent_spawner_collection = new Array<OpponentSpawner>();

		for (i in 0...level.opponent_spawners.length)
		{
			var opponent_spawner = new OpponentSpawner();
			var data:OpponentSpawnerData = level.opponent_spawners[i];
			opponent_spawner.spawn_interval = data.spawn_interval;
			opponent_spawner.object_min_x = data.object_min_x;
			opponent_spawner.object_max_x = data.object_max_x;
			opponent_spawner.object_min_y = data.object_min_y;
			opponent_spawner.object_max_y = data.object_max_y;
			opponent_spawner.object_start_x = data.object_start_x;
			opponent_spawner.object_start_y = data.object_start_y;
			opponent_spawner.object_x_velocity = data.object_x_velocity;
			opponent_spawner.object_y_velocity = data.object_y_velocity;
		
			oppenent_spawner_collection.push(opponent_spawner);
			add(opponent_spawner);
		}
		this.opponent_collection = new OpponentSpriteCollection();

		add(grid_sprite_collection);
		add(opponent_collection);
		add(player);
		stamina_bar = new FlxBar(10, 10, LEFT_TO_RIGHT, 100, 10, player.health_stamina, 0, player.max_heath_stamina);
		add(stamina_bar);
		pol_bar = new FlxBar(10, 25, LEFT_TO_RIGHT, 100, 10, player.negative_health_pol, -50, 50);
		add(pol_bar);
		auth_bar = new FlxBar(10, 40, LEFT_TO_RIGHT, 100, 10, player.negative_heath_authoritarian, -50, 50);
		add(auth_bar);
		political_compass = new PoliticalCompassSprite();
		add(political_compass);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		

		var player_grid_location = grid.world_to_grid(new Point(player.x, player.y));
		if (grid.valueAt(cast player_grid_location.x, cast player_grid_location.y - 1) == 1)
		{
			player.can_move_up = true;
		}
		else
		{
			player.can_move_up = false;
		}

		if (grid.valueAt(cast player_grid_location.x, cast player_grid_location.y + 1) == 1)
		{
			player.can_move_down = true;
		}
		else
		{
			player.can_move_down = false;
		}

		if (grid.valueAt(cast player_grid_location.x - 1, cast player_grid_location.y) == 1)
		{
			player.can_move_left = true;
		}
		else
		{
			player.can_move_left = false;
		}

		if (grid.valueAt(cast player_grid_location.x + 1, cast player_grid_location.y) == 1)
		{
			player.can_move_right = true;
		}
		else
		{
			player.can_move_right = false;
		}

		for (i in 0...this.oppenent_spawner_collection.length)
		{
			var opponent_spawner = this.oppenent_spawner_collection[i];
			if (opponent_spawner.spawn)
			{
				var opp = opponent_collection.getFirstDead();
				if (opp == null)
				{
					opp = new Opponent();
					opp.makeGraphic(grid.cell_width, grid.cell_height);
					opp.alpha = 0.5;
					opponent_collection.add(opp);
				}
				else
				{
					opp.revive();
				}

				opp.x = opponent_spawner.object_start_x;
				opp.y = opponent_spawner.object_start_y;
				opp.min_x = opponent_spawner.object_min_x;
				opp.max_x = opponent_spawner.object_max_x;
				opp.min_y = opponent_spawner.object_min_y;
				opp.max_y = opponent_spawner.object_max_y;
				opp.velocity.x = opponent_spawner.object_x_velocity;
				opp.velocity.y = opponent_spawner.object_y_velocity;
				opp.illegal = FlxG.random.bool(10);
				if (opp.illegal)
				{
					opp.color = FlxColor.WHITE;
				}
				else
				{
					var quadrant = FlxG.random.int(0, 3);
					switch (quadrant)
					{
						case 0:
							opp.auth_value = 10;
							opp.pol_value = -10;
							opp.color = FlxColor.RED;
						case 1:
							opp.auth_value = 10;
							opp.pol_value = 10;
							opp.color = FlxColor.BLUE;
						case 2:
							opp.auth_value = -10;
							opp.pol_value = 10;
							opp.color = FlxColor.PURPLE;
						case 3:
							opp.auth_value = -10;
							opp.pol_value = -10;
							opp.color = FlxColor.GREEN;
					}
				}
			}
		}

		stamina_bar.value = player.health_stamina;
		pol_bar.value = player.negative_health_pol;
		auth_bar.value = player.negative_heath_authoritarian;

		political_compass.x_value = -player.negative_health_pol;
		political_compass.y_value = player.negative_heath_authoritarian;
		FlxG.overlap(player, opponent_collection, (player:Player, opponent:Opponent) ->
		{
			player.health_stamina += elapsed * 2;

			player.negative_heath_authoritarian += elapsed * opponent.auth_value;
			player.negative_health_pol += elapsed * opponent.pol_value;

			if (opponent.illegal)
			{
				player.negative_health_illegal = true;
				game_over = true;
			}
		});

		if (player.health_stamina == 0)
		{
			game_over = true;
		}

		if (game_over)
		{
			if (!just_game_over)
			{
				// FlxG.camera.fade(FlxColor.BLACK, 1.0, false);
				just_game_over = true;
			}
		}
	}
}
