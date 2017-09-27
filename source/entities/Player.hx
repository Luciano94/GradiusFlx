package entities;

import entities.Bala;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;

class Player extends FlxSprite 
{
	private var speed:Int;
	private var vidas(get, null):Int;
	private var framesEntreBala:Int;
	private var balaArray:FlxTypedGroup<Bala>;
	private var rTime:FlxRandom;
	private var powerUpState:Int;
	public var bala(get, null):Bala;
	
	public function new(?X:Float=0, ?Y:Float=0, playerBalaArray:FlxTypedGroup<Bala>) 
	{
		super(X, Y);
		
		loadGraphic(AssetPaths.spaceship__png, true, 32, 16);
		balaArray = playerBalaArray;
		speed = Reg.playerNormalSpeed;
		vidas = Reg.playerMaxLives;
		framesEntreBala = Reg.playerFramesEntreBala;
		powerUpState = 0;
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		velocity.set(Reg.cameraSpeed, 0);
		framesEntreBala++;
		
		movimiento();
		disparo();
		colision();
	}
	
	function disparo() 
	{
		if (FlxG.keys.justPressed.SPACE && framesEntreBala >= 5)
		{
			var nuevaBala = new Bala(x + width, y + height / 2);
			balaArray.add(nuevaBala);
			framesEntreBala = 0;
		}
	}
	
	function powerUpCollision()
	{
		powerUpState++;
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
	
	function colision():Void 
	{
		//if (x > FlxG.width - width)
			//x = FlxG.width - width;
		//else 
			//if (x < FlxG.width - FlxG.width)
				//x = FlxG.width - FlxG.width;
		
		if (y > FlxG.height - height)
			morido();
		else 
			if (y < FlxG.height - FlxG.height)
				morido();
	}
	
	function morido() 
	{
		kill();
	}
	
	function get_vidas():Int 
	{
		return vidas;
	}
}