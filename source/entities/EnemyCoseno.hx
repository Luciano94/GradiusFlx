package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup;

class EnemyCoseno extends FlxSprite 
{ 
	private var hitPoints:Int;
	private var normalizado:Bool;
	public var pwUp:FlxTypedGroup<PowerUp>;
	
	public function new(?X:Float = 0, ?Y:Float = 0, ?Normalizado:Bool = true, PwUp:FlxTypedGroup<PowerUp>)
	{
		super(X, Y);
		
		loadGraphic(AssetPaths.enemyCoseno__png, true, 32, 16);
		normalizado = Normalizado;
		
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
		
		hitPoints = Reg.enemyCShp;
		velocity.y = Reg.enemyCSpeedY;
		velocity.x = Reg.enemyCSpeedX;
		FlxTween.tween(velocity, {y: 120}, 1.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});	//This is messing with the collision.
	}
	
	public function getDamage():Void
	{
		hitPoints--;
		if (hitPoints == 0)
			destroy();
	}
	
	override public function destroy():Void
	{
		super.destroy();
		
		if (!normalizado)
		{
		var nuevoPowerUp = new PowerUp(x, y);
		pwUp.add(nuevoPowerUp);
		}
	}
}