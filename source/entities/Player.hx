package entities;

import entities.Bala;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends FlxSprite 
{
	private var speed:Int;
	private var framesEntreBala:Int;
	private var rTime:FlxRandom;
	public var bala(get, null):Bala;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.spaceship__png, true, 32, 16);
		speed = Reg.playerNormalSpeed;
		framesEntreBala = Reg.playerFramesEntreBala;
		bala = new Bala(this.x + 16, this.y + 5);
		FlxG.state.add(bala);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		velocity.set(Reg.cameraSpeed, 0);
		
		movimiento();
		colision();
		disparo();
	}
	
	function get_bala():Bala 
	{
		return bala;
	}
	
	function movimiento():Void 
	{
		if (FlxG.keys.pressed.UP)
			velocity.y -= speed;
		if (FlxG.keys.pressed.DOWN)
			velocity.y += speed;
		if (FlxG.keys.pressed.LEFT)
			velocity.x -= speed;
		if (FlxG.keys.pressed.RIGHT)
			velocity.x += speed;
	}
	
	function disparo():Void 
	{
		framesEntreBala++;
		if (FlxG.keys.pressed.X && framesEntreBala >= 15)
		{
			bala.reset(this.x + 16, this.y + 5);
			
			framesEntreBala = 0;
		}
		bala.velocity.x = Reg.playerBalaSpeed;
	}
	
	function colision():Void 
	{
		if (x>FlxG.width-width)
			x = FlxG.width - width;
		if (x<FlxG.width - FlxG.width)
			x = FlxG.width - FlxG.width;
		
		if (y>FlxG.height-height)
			y = FlxG.height - height;
		if (y<FlxG.height - FlxG.height)
			y = FlxG.height - FlxG.height;
	}
}