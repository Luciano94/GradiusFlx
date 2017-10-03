package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

class Bala extends FlxSprite 
{
	private var speed:Int;
	private var laser:Bool;
	
	public function new(?X:Float = 0, ?Y:Float = 0, ?_laser:Bool) 
	{
		super(X, Y);
		
		speed = Reg.playerBalaSpeed;
		velocity.x = speed;
		laser = _laser;
		loadGraphic(AssetPaths.balaPlayer__png, true, 8, 6);
		animation.add("shot", [0]); // Estado normal de la bala
		animation.add("laser", [1]); // Estado cuando el PowerUp "Laser" esta activado
		if(!laser)				  // Esto es para cuando tengamos el PowerUp Laser
			animation.play("shot");
		else
			animation.play("laser");
		
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		checkBoundaries();
	}
	
	private function checkBoundaries():Void 
	{
		if (x > camera.scroll.x + FlxG.width || y < 0) // Puse 'y<0' para cuando el PUp 'doble' esté activado	
			destroy();
	}
}