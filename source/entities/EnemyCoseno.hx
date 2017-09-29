package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

/**
 * ...
 * @author Aleman5
 */
class EnemyCoseno extends FlxSprite 
{ // Se llama 'coseno' porque el patrón que va a seguir va a ser el del 'coseno'
  // https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Cosine.svg/350px-Cosine.svg.png
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.enemyCoseno__png, true, 32, 16);
		width = 16;
		height = 14;
		offset.set(8, 1);
		velocity.y = Reg.enemyCSpeedY;
		velocity.x = Reg.enemyCSpeedX;
		FlxTween.tween(velocity, {y: 120}, 1.5, {type: FlxTween.PINGPONG, ease: FlxEase.sineInOut});
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
}