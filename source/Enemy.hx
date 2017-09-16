package;

import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.FlxGraphic;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxPath;

/**
 * ...
 * @author ...
 */
class Enemy extends FlxSprite
{

	public function new(?X:Float=0, ?Y:Float=0, ?width:Int=0, ?height:Int=0, asset:FlxGraphicAsset) 
	{
		super(X, Y);
		
		loadGraphic(asset, true, width, height);
		
		setFacingFlip(FlxObject.RIGHT, false, false);
		setFacingFlip(FlxObject.LEFT, true, false);
		
		setSize(width, height);
		
		
		acceleration.y = 1200;
		
		solid = true;
	}
	
}