package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class PwUpBar extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.pwUpBar__png, true, 255, 16);
		animation.add("idle", [0]);
		animation.add("speed", [1]);
		animation.add("laser", [2]);
		animation.add("misil", [3]);
		animation.add("option", [4]);
		animation.add("shield", [5]);
		animation.play("idle");
		velocity.set(Reg.cameraSpeed, 0);
	}
}