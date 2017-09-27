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
		/*loadGraphic(AssetPaths.enemyPerseguidor__png, false, 32, 16);
		animation.add("idle", [0]);
		animation.add("arriba", [1]);
		animation.add("abajo", [2]);
		animation.play("idle");*/
	}
	/*override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		movimiento();
	}
	
	function movimiento():Void 
	{
		velocity.x = -Reg.enemySpeedXY;
		if (y == Player.Y)
		{
			velocity.y = 0;
			animation.play("idle");
		}
		else if (y <= Player.Y)
		{
			velocity.y = -Reg.enemySpeedXY;
			animation.play("arriba");
		}
		else
		{
			velocity.y = Reg.enemySpeedXY;
			animation.play("abajo");
		}
	}*/
	
}