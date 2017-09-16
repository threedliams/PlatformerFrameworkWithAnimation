package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	private var player:PlayerSprite;
	private var enemy:Enemy;
	
	private var map:FlxOgmoLoader;
	private var mWalls:FlxTilemap;
	
	private var walls:FlxTypedGroup<WallSprite>;
	private var floors:FlxTypedGroup<FloorSprite>;
	
	override public function create():Void
	{
		FlxG.scaleMode = new RatioScaleMode();
		
		
		map = new FlxOgmoLoader(AssetPaths.room_001__oel);
		mWalls = map.loadTilemap(AssetPaths.Middle_grass_platform__png, 40, 46, "walls");
		mWalls.follow();
		mWalls.setTileProperties(1, FlxObject.UP);
		add(mWalls);
		
		
		player = new PlayerSprite();
		map.loadEntities(placeEntities, "entities");
		add(player);
		
		enemy = new Slime(50, 100, 44, 29, AssetPaths.Slime_monster__png);
		add(enemy);
		
		
		walls = new FlxTypedGroup<WallSprite>();
		
		walls.add(new WallSprite(0, 0, 640, 20));
		walls.add(new WallSprite(0, 0, 20, 480));
		walls.add(new WallSprite(620, 0, 20, 480));
		
		for (wall in walls)
		{
			add(wall);
		}
		
		floors = new FlxTypedGroup<FloorSprite>();
		
		floors.add(new FloorSprite(0, 460, 640, 20));
		
		for (floor in floors)
		{
			add(floor);
		}
		
		
		
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		FlxG.collide(player, mWalls);
		FlxG.collide(player, walls);
		FlxG.overlap(player, floors, collideEntityWithFloor);
		
		FlxG.collide(enemy, mWalls);
		FlxG.collide(enemy, walls);
		FlxG.overlap(enemy, floors, collideEntityWithFloor);
		
		super.update(elapsed);
	}
	
	function collideEntityWithFloor(entity:FlxSprite, floor:FloorSprite)
	{
		entity.velocity.y = 0;
		FlxG.collide(entity, floor);
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player")
		{
			player.x = x;
			player.y = y;
		}
	}
}
