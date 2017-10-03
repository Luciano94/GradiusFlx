package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class EnemyCoseno extends FlxSprite 
{ 
	private var hitPoints:Int;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		loadGraphic(AssetPaths.enemyCoseno__png, true, 32, 16);
		
		width = 16;
		height = 14;
		offset.set(8, 1);
		hitPoints = Reg.enemyCShp;
		
		velocity.y = Reg.enemyCSpeedY;
		velocity.x = Reg.enemyCSpeedX;
		//FlxTween.tween(velocity, {y: 120}, 1.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});	This is messing with the collision.
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		
	}
	
	public function getDamage():Void
	{
		hitPoints--;
		if (hitPoints == 0)
			destroy();
	}
}