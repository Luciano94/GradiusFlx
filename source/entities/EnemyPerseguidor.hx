package entities;

import entities.Player;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRandom;

class EnemyPerseguidor extends FlxSprite 
{
	private var normalizado:Bool;
	private var proba:FlxRandom;
	public var pwUp:FlxTypedGroup<PowerUp>;
	private var outOfBounds:Bool;
	
	public function new(?X:Float = 0, ?Y:Float = 0, PwUp:FlxTypedGroup<PowerUp>)
	{
		super(X, Y);
		
		loadGraphic(AssetPaths.enemyPerseguidor__png, true, 32, 16);
		
		width = 15;
		height = 14;
		offset.set(9, 1);
		outOfBounds = false;
		pwUp = PwUp;
		
		proba = new FlxRandom();
		normalizado = proba.bool(70);
		
		animation.add("idle", [0]);
		animation.add("arriba", [1]);
		animation.add("abajo", [2]);
		
		animation.add("idleP", [3]);
		animation.add("arribaP", [4]);
		animation.add("abajoP", [5]);
		
		if(normalizado)
			animation.play("idle");
		else
			animation.play("idleP");
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		movimiento();
		checkBoundaries();
	}
	
	public function movimiento():Void 
	{	
		if (x < camera.scroll.x + FlxG.width + 16)
		{	
			if (y >= Reg.playerRef.y + 2)
			{
				velocity.x = -Reg.enemySpeedX;
				velocity.y = -Reg.enemySpeedY;
				if(normalizado)
					animation.play("arriba");
				else
					animation.play("arribaP");
			}
			else 
				if (y <= Reg.playerRef.y - 2)
				{
					velocity.x = -Reg.enemySpeedX;
					velocity.y = Reg.enemySpeedY;
					if(normalizado)
						animation.play("abajo");
					else
						animation.play("abajoP");
				}
				else
				{
					velocity.x = -Reg.enemySpeedX * 2.5;
					velocity.y = 0;
					if(normalizado)
						animation.play("idle");
					else
						animation.play("idleP");
				}
		}
	}
	
	private function checkBoundaries():Void
	{
		if (x < camera.scroll.x - FlxG.width)
		{
			outOfBounds = true;
			destroy();
		}
	}
	
	override public function destroy():Void
	{
		super.destroy();
		
		if (!outOfBounds)
		{
			FlxG.sound.play(AssetPaths.enemyExploding__wav);
			if (!normalizado)
			{
				var nuevoPowerUp = new PowerUp(x, y);
				pwUp.add(nuevoPowerUp);
			}
		}
	}
}