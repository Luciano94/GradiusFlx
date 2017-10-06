package entities;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class BalaBoss extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.balaEne__png, true, 4, 4);
		velocity.x = -50;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		checkBoundaries();
	}
	
	private function checkBoundaries():Void
	{
		if (x > camera.scroll.x + FlxG.width - width)
			destroy();
		if (x < camera.scroll.x)
			destroy();
	}
}