package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import entities.Bala;

class Options extends FlxSprite 
{
	private var speed:Int;
	private var framesEntreBala:Int;
	public var bala(get, null):Bala;
	private var powerUpState: Int;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.spaceship__png, true, 32, 16);
		speed = Reg.playerNormalSpeed;
		framesEntreBala = Reg.playerFramesEntreBala;
		bala = new Bala(this.x + 16, this.y + 5);
		powerUpState = 0;
	}
	
	/*function setPlayer(p:Player)
	{
		
	}*/
	
	override public function update(elapsed: Float): Void
	{
		super.update(elapsed);
		
		optionMovment();
		colision();
		
	}
	
	function get_bala():Bala 
	{
		return bala;
	}
		
	function disparo():Void 
	{
		framesEntreBala++;
		if (FlxG.keys.pressed.X && framesEntreBala >= 10)
		{
			//bala.reset(this.x + 16, this.y + 5);
			get_bala();
			bala = new Bala(this.x + 16, this.y + 5);
			bala.velocity.x = Reg.playerBalaSpeed;
			framesEntreBala = 0;
		}
		bala.velocity.x = Reg.playerBalaSpeed;
	}
	
	function optionMovment():Void
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
	
	function colision():Void 
	{
		if (x == 0 || x == FlxG.width)
			velocity.x = 0;
		if (y == 0 || y == FlxG.height)
			velocity.y = 0;
	}
}