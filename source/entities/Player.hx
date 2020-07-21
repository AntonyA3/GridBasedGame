package entities;

import flixel.input.keyboard.FlxKey;
import lime.ui.KeyCode;
import lime.tools.Keystore;
import enums.Direction;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class Player extends FlxSprite {
    public var x_move_increment = 64;
    public var y_move_increment = 64;
    public var x_speed = 256 * 8;
    public var y_speed = 256 * 4;

    private var moving = false;
    private var target_x = 0.0;
    private var target_y = 0.0;
    private var direction = Direction.NONE;
    
    public var can_move_up = true;
    public var can_move_down = true;
    public var can_move_left = true;
    public var can_move_right = true;

    public var health_stamina = 5.0;
    public var max_heath_stamina = 5.0;

    public var negative_heath_authoritarian = 0.0;
    public var negative_health_pol = 0.0;

    public var negative_health_illegal = false;

    
    public function new() {
        super();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        
        health_stamina -= elapsed;
        if(health_stamina > max_heath_stamina){
            this.health_stamina = max_heath_stamina;
        }
        if(this.health_stamina < 0){
            this.health_stamina = 0;
        }

        if (!moving){
            
            if (FlxG.keys.justPressed.W) {
                if(can_move_up){
					moving = true;
					target_y = y - y_move_increment;
					direction = Direction.UP;
                }
            }
            else if (FlxG.keys.justPressed.S) {
                if(can_move_down){
                    moving = true;
                    target_y = y + y_move_increment;
                    direction = Direction.DOWN; 
                }
                

            }
            else if (FlxG.keys.justPressed.A) {
                if (can_move_left){
                    moving = true;
                    target_x = x - x_move_increment;
                    direction = Direction.LEFT;
                }
                
            }
            else if (FlxG.keys.justPressed.D) {
                if(can_move_right){
                    moving = true;
                    target_x = x + x_move_increment;
                    direction = Direction.RIGHT;
                }
                
            }
        }
        

        if (moving){
            switch (direction){
                case DOWN:
                    if(y + velocity.y * elapsed < target_y){
						this.velocity.y =y_speed;
                    }else {
                        velocity.y = 0;
                        y = target_y;
                        moving = false;
                    }
                case UP:
					if (y + velocity.y * elapsed > target_y)
					{
						this.velocity.y = -y_speed;
					}
					else
					{
						velocity.y = 0;
						y = target_y;
                        moving = false;
                    }
                case LEFT:
                    if (x + velocity.x * elapsed > target_x){
                        this.velocity.x = -x_speed;
                    }else {
                        this.velocity.x = 0;
                        x = target_x;
                        moving = false;
                    }

                case RIGHT:
                    if (x + velocity.x * elapsed < target_x){
                        this.velocity.x = x_speed;
                    }else {
                        this.velocity.x = 0;
                        x = target_x;
                        moving = false;
                    }
                default:  
            }
        }

    }
}