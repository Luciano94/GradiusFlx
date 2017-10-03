package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class PowerUp extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.powerUp__png, true, 32, 32);
		animation.add("idle", [0, 1, 2, 4, 5, 6, 7, 8, 9, 10], 12, true);
		animation.play("idle");
	}
	
}