package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite 
{
	private var speed:Int;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		speed = Reg.playerNormalSpeed;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		velocty.set(Reg.cameraSpeed, 0);
		
		if (FlxG.keys.pressed.UP)
			velocity.y -= speed;
		if (FlxG.keys.pressed.DOWN)
			velocity.y += speed;
		if (FlxG.keys.pressed.LEFT)
			velocity.x -= speed);
		if (FlxG.keys.pressed.RIGHT)
			velocity.
	}
	
}