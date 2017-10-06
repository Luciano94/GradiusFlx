package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

class BalaEne extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.balaEne__png, true, 4, 4);
		velocity.y = -50;
	}
	
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);
	}
}