package entities;

import entities.Player;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author Aleman5
 */
class EnemyPerseguidor extends FlxSprite 
{
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.enemyPerseguidor__png, true, 32, 16);
		
		width = 15;
		height = 14;
		offset.set(9, 1);
		
		animation.add("idle", [0]);
		animation.add("arriba", [1]);
		animation.add("abajo", [2]);
		animation.play("idle");
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		movimiento();
	}
	
	function movimiento():Void 
	{
		
		if (y >= Reg.playerRef.y + 2)
		{
			velocity.x = -Reg.enemySpeedX;
			velocity.y = -Reg.enemySpeedY;
			animation.play("arriba");
		}
		else if (y <= Reg.playerRef.y - 2)
		{
			velocity.x = -Reg.enemySpeedX;
			velocity.y = Reg.enemySpeedY;
			animation.play("abajo");
		}
		else
		{
			velocity.x = -Reg.enemySpeedX * 2.5;
			velocity.y = 0;
			animation.play("idle");
		}
	}
	
}