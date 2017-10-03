package entities;

import entities.Bala;
import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;

class Options extends Player 
{
	private var player:Player;
	
	public function new(?X:Float=0, ?Y:Float=0, playerBalaArray:FlxTypedGroup<Bala>, playerMisilArray:FlxTypedGroup<Misil>, _player:Player) 
	{
		super(X, Y, playerBalaArray, playerMisilArray);
		
		loadGraphic(AssetPaths.options__png, true, 16, 16);
		animation.add("idle", [0, 1, 2, 4, 5], 10, true);
		animation.play("idle");
		player = _player;
		faster = Reg.playerPowerUpSpeed;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		/*Power Up*/
		if (player.isDoubleSpeed())
			speed = faster;
		if (player.isLaser())
			laser = true;
		/*Tracking*/
		movimiento();
	}
	
	override function movimiento():Void 
	{
		if (player.velocity.y != 0)
		{
			if (y > player.y - player.height)
				velocity.y -= speed;
			if (y < player.y + player.height)
				velocity.y += speed;
		}
		if (player.velocity.x != Reg.cameraSpeed)
		{
			if (x > player.x + player.width)
				velocity.x -= speed + Reg.cameraSpeed;
			if (x < player.x - player.width)
				velocity.x += speed;
		}
	}
}