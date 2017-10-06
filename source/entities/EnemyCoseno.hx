package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRandom;

class EnemyCoseno extends FlxSprite 
{ 
	private var hitPoints:Int;
	private var normalizado:Bool;
	private var proba:FlxRandom;
	public var pwUp:FlxTypedGroup<PowerUp>;
	private var outOfBounds:Bool;
	
	public function new(?X:Float = 0, ?Y:Float = 0, PwUp:FlxTypedGroup<PowerUp>)
	{
		super(X, Y);
		
		loadGraphic(AssetPaths.enemyCoseno__png, true, 32, 16);
		
		proba = new FlxRandom();
		normalizado = proba.bool(70);
		
		
		if (normalizado)
		{
			animation.add("elPosta", [0]);
			animation.play("elPosta");
		}
		else 
		{
			animation.add("elNoPosta", [1]);
			animation.play("elNoPosta");
		}
		width = 16;
		height = 14;
		offset.set(8, 1);
		pwUp = PwUp;
		outOfBounds = false;
		
		hitPoints = Reg.enemyCShp;
		//	FlxTween.tween(velocity, {y: 120}, 1.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});	//This is messing with the whole freaking game!
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (x < camera.scroll.x + FlxG.width + 16)
		{
			velocity.x = -50;
		}
		checkBoundaries();
	}

	public function getDamage():Void
	{
		hitPoints--;
		if (hitPoints == 0)
			destroy();
		else
			FlxG.sound.play(AssetPaths.damageEnemy__wav);
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