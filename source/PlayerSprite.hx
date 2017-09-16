package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class PlayerSprite extends FlxSprite
{
	public var speed:Float = 200;
	private var isJumping:Bool = false;
	public var jumpSpeed:Float = 600;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		loadGraphic(AssetPaths.Green_hooded_character__png, true, 58, 68);
		
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		animation.add("lr", [0, 2, 0, 3], 6, true);
		animation.add("idle", [0, 1], 2, true);
		animation.add("jump", [4], 1, false);
		
		drag.x = 800;
		
		acceleration.y = 1200;
		
		elasticity = 0;
		solid = true;
	}
	
	private function movement():Void {
		var _up:Bool = false;
		var _down:Bool = false;
		var _left:Bool = false;
		var _right:Bool = false;
		var startJump:Bool = false;
		var jumpReleased:Bool = false;
		
		_up = FlxG.keys.anyPressed([UP, W]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);
		startJump = FlxG.keys.justPressed.SPACE;
		jumpReleased = FlxG.keys.justReleased.SPACE;
		
		if (_up && _down) {
			_up = _down = false;
		}
		if (_left && _right) {
			_left = _right = false;
		}
		
		if (_left || _right || startJump || jumpReleased) {
			var mA:Float = 0;
			if (_left) {
				velocity.set( -speed, velocity.y );
				facing = FlxObject.RIGHT;
			}
			else if (_right) {
				velocity.set(speed, velocity.y );
				facing = FlxObject.LEFT;
			}
			if (startJump && velocity.y == 0 && !isJumping)
			{
				isJumping = true;
				velocity.y = -jumpSpeed;
			}
			else if (jumpReleased && isJumping)
			{
				isJumping = false;
				if (velocity.y < 0)
				{
				velocity.y = 0;
				}
			}
			
			velocity.rotate(FlxPoint.weak(0, 0), mA);
		}
		if(velocity.y != 0)
		{	
			if (velocity.y < 0)
			{
				animation.play("jump");
			}
			else
			{
				animation.stop();
			}
		}
		else if (velocity.x != 0)
		{
			switch(facing)
			{
				case FlxObject.LEFT, FlxObject.RIGHT:
					animation.play("lr");
				default:
					animation.play("idle");
			}
		}
		else {
			animation.play("idle"); 
		}
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		movement();
		super.update(elapsed);
	}
}