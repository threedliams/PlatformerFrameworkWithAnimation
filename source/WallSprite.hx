package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author ...
 */
class WallSprite extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?W:Int=16, ?H:Int=16) 
	{
		super(X, Y);
		
		makeGraphic(W, H, FlxColor.GRAY);
		
		solid = true;
		immovable = true;
	}
	
}