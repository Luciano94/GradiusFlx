package entities;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author holis
 */
class Boss extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.powerUp__png, 32, 32, false);
		velocity.set(Reg.cameraSpeed, Reg.playerNormalSpeed);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
	private function movimiento()
	{
		if (y <= 0 + height)
			velocity.y += velocity.y;
		if (y >= FlxG.height - height)
			velocity.y -= velocity.y;
	}
}