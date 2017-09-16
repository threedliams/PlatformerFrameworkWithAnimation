package;

import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Slime extends Enemy
{

	public function new(?X:Float=0, ?Y:Float=0, ?width:Int=0, ?height:Int=0, asset:FlxGraphicAsset) 
	{
		super(X, Y, width, height, asset);
		
		animation.add("idle", [0, 1], 2, true);
		animation.add("lr", [0, 2], 4, true);
		animation.add("hit", [0, 3], 2, false);
		animation.add("die", [0, 3, 4, 5, 6], 6, true);
		
		alpha = .85;
		
		animation.play("die");
	}
	
}