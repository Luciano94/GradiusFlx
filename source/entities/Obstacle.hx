package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxRandom;

class Obstacle extends FlxSprite 
{
	private var speed:Int;
	private var randomVelocity:FlxRandom;
	private var outOfBounds:Bool;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		randomVelocity = new FlxRandom();
		speed = randomVelocity.int(-50, -5);
		velocity.x = speed;
		outOfBounds = false;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (x < camera.scroll.x + FlxG.width + 16)
			velocity.x = speed;
		checkBoundaries();
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
			FlxG.sound.play(AssetPaths.enemyExploding__wav);
	}
}