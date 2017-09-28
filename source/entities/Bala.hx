package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

/**
 * ...
 * @author Aleman5
 */
class Bala extends FlxSprite 
{
	private var speed:Int;
	
	public function new(?X:Float = 0, ?Y:Float = 0) 
	{
		super(X, Y);
		
		speed = Reg.playerBalaSpeed;
		velocity.x = speed;
		loadGraphic(AssetPaths.balaPlayer__png, false, 4, 2);
		animation.add("s0", [0]); // Estado normal de la bala
		animation.add("s1", [1]); // Estado cuando el PowerUp "Laser" esta activado
		//if(laser)				  // Esto es para cuando tengamos el PowerUp Laser
			animation.play("s0");
		//else
		//	animation.play("s1");
		
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		//checkBoundaries();	This method has to be fixed.
	}
	
	function checkBoundaries():Void 
	{
		if (x > FlxG.camera.camera.x + FlxG.width || y < 0) // Puse 'y<0' para cuando el PUp 'doble' esté activado
			kill();
	}
	
}