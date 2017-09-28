package entities;

import entities.Bala;
import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;

/**
 * ...
 * @author ...
 */
class Options extends Player 
{
	
	private var timerMov:Float;
	private var player:Player;

	public function new(?X:Float=0, ?Y:Float=0, playerBalaArray:FlxTypedGroup<Bala>, _player:Player) 
	{
		super(X, Y, playerBalaArray);
		player = _player;
		timerMov = 0;
	}
	
	override function movimiento():Void 
	{

	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (y > player.y - player.height)
			velocity.y -= speed;
		if (y < player.y + player.height)
			velocity.y += speed;
		if (x > player.x + player.width)
			velocity.x -= speed + Reg.cameraSpeed;
		if (x < player.x - player.width)
			velocity.x += speed;
	}

	
}