package entities;

import entities.Bala;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite 
{
	private var speed:Int;
	private var framesEntreBala:Int;
	public var bala(get, null):Bala;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		speed = Reg.playerNormalSpeed;
		framesEntreBala = Reg.playerFramesEntreBala;
		bala = new Bala();
		FlxG.state.add(bala);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		velocity.set(Reg.cameraSpeed, 0);
		
		if (FlxG.keys.pressed.UP) // Movimiento
			velocity.y -= speed;
		if (FlxG.keys.pressed.DOWN)
			velocity.y += speed;
		if (FlxG.keys.pressed.LEFT)
			velocity.x -= speed;
		if (FlxG.keys.pressed.RIGHT)
			velocity.x += speed;
		
			disparo();
	}
	
	function get_bala():Bala 
	{
		return bala;
	}
	
	function disparo():Void 
	{
	framesEntreBala++;
	if (FlxG.keys.pressed.X && framesEntreBala == 10){
		bala.reset(this.x + 16, this.y + 5);
		bala.velocity.x = Reg.playerBalaSpeed;
		framesEntreBala = 0;
	}
	}
	
}