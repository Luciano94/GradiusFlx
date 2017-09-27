package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author Aleman5
 */
class BalaEne extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//loadGraphic(AssetPaths.balaEne__png);
	}
	
	override public function update (elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (x < 0 || y < 0 || x > FlxG.width || y > FlxG.height) 
			kill();
	}
}