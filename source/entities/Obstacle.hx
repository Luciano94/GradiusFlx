package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxRandom;

class Obstacle extends FlxSprite 
{
	private var speed:Int;
	private var randomVelocity:FlxRandom;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		randomVelocity = new FlxRandom();
		speed = randomVelocity.int(-50, -5);
		velocity.x = speed;
		
	}
	
	override public function destroy():Void
	{
		super.destroy();
		
		FlxG.sound.play(AssetPaths.enemyExploding__wav);
	}
}