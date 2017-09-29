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
	private var faster:Int;
	private var vidas(get, null):Int;
	private var framesEntreBala:Int;
	private var balaArray:FlxTypedGroup<Bala>;
	private var powerUpState:Int;
	public var bala(get, null):Bala;
	
	public function new(?X:Float=0, ?Y:Float=0, playerBalaArray:FlxTypedGroup<Bala>) 
	{
		super(X, Y);
		/*Graphic*/
		loadGraphic(AssetPaths.spaceship__png, true, 32, 24);
		/*Speed*/
		speed = Reg.playerNormalSpeed;
		/*Lives*/
		vidas = Reg.playerMaxLives;
		/*Bullets*/
		balaArray = playerBalaArray;
		framesEntreBala = Reg.playerFramesEntreBala;
		/*Power Up*/
		powerUpState = 0;
		faster = speed * 2;
		/*Animations*/
		animation.add("idle", [0, 1, 2], 6, true);
		animation.add("moveUp", [5]);
		animation.add("moveDown", [6]);
		animation.add("moveBackwards", [4]);
		animation.add("moveForward", [3]);
		animation.add("explode", [7, 8, 9], 1, true);
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		velocity.set(Reg.cameraSpeed, 0);
		framesEntreBala++;
		animation.play("idle");
		
		movimiento();
		disparo();
	}
	/*-----------------------Player-----------------------*/
	private function disparo() 
	{
		if (FlxG.keys.justPressed.SPACE && framesEntreBala >= 5)
		{
			var nuevaBala = new Bala(x + width, y + height / 2);
			
			balaArray.add(nuevaBala);
			framesEntreBala = 0;
		}
	}
	
	private function movimiento():Void 
	{
		if (FlxG.keys.pressed.UP)
		{
			velocity.y -= speed;
			animation.play("moveUp");
		}
		if (FlxG.keys.pressed.DOWN)
		{
			velocity.y += speed;
			animation.play("moveDown");
		}
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x -= speed;
			animation.play("moveBackwards");
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x += speed;
			animation.play("moveForward");
		}
	}
	
	override public function kill():Void
	{
		animation.play("explode");
		
		super.kill();
		
		if (vidas == 0)
			Reg.gameOver = true;
		else
		{
			vidas--;
			reset(10, FlxG.height / 2);
		}
	}
	
	public function get_vidas():Int 
	{
		return vidas;
	}
	
	public function get_bala():Bala 
	{
		return bala;
	}
	/*-----------------------Power Up-----------------------*/
	public function powerUpCollision()
	{
		powerUpState++;
	}
	
	public function doubleSpeed():Void
	{
		speed = faster;
	}
		
	public function getPowerUpState():Int
	{
		return powerUpState;
	}
	
	public function resetPowerUpState()
	{
		powerUpState = 0;
	}
}