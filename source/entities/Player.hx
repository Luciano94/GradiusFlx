package entities;

import entities.Bala;
import entities.Player.State;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;

enum State
{
	Alive; Exploding; Destroyed;
}
class Player extends FlxSprite 
{
	/*Player*/
	private var speed:Int;
	public var vidas(get, null):Int;
	private var framesEntreBala:Int;
	private var balaArray:FlxTypedGroup<Bala>;
	public var bala(get, null):Bala;
	private var state:State;
	/*Power Ups*/
	private var faster:Int;
	private var shield: Bool;
	private var laser: Bool;
	private var misil: Bool;
	private var misilArray:FlxTypedGroup<Misil>;
	private var framesEntreMisil:Int;
	public var powerUpState:Int;
	
	public function new(?X:Float=0, ?Y:Float=0, playerBalaArray:FlxTypedGroup<Bala>, playermisilArray:FlxTypedGroup<Misil>) 
	{
		super(X, Y);
		
		/*Graphic*/
		loadGraphic(AssetPaths.spaceship1__png, true, 32, 24);
		/*Speed*/
		speed = Reg.playerNormalSpeed;
		/*State*/
		state = State.Alive;
		/*Lives*/
		vidas = Reg.playerMaxLives;
		/*Bullets*/
		balaArray = playerBalaArray;
		framesEntreBala = Reg.playerFramesEntreBala;
		/*Power Up*/
		misilArray = playermisilArray;
		framesEntreMisil = Reg.playerFramesEntreBala;
		powerUpState = 0;
		faster = Reg.playerPowerUpSpeed;
		shield = false;
		laser = false;
		misil = false;
		/*Animations*/
		animation.add("idle", [0, 1, 2], 6, true);
		animation.add("moveUp", [5]);
		animation.add("moveDown", [6]);
		animation.add("moveBackwards", [4]);
		animation.add("moveForward", [3]);
		animation.add("explode", [7, 8, 9], 6, false);
		/*Shield*/
		animation.add("idleS", [10, 11, 12], 6, true);
		animation.add("moveUpS", [15]);
		animation.add("moveDownS", [16]);
		animation.add("moveBackwardsS", [14]);
		animation.add("moveForwardS", [13]);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		switch (state) 
		{
			case State.Alive:
				velocity.set(Reg.cameraSpeed, 0);
				framesEntreBala++;
				framesEntreMisil++;
				if (shield)
					animation.play("idleS");
				else
					animation.play("idle");
				movimiento();
				checkBoundaries();
				disparo();
			case State.Exploding:
				velocity.set(0, 0);
				if (animation.name == "explode" && animation.finished)
				{
					kill();
				}
			case State.Destroyed:
		}
	}
	/*-----------------------Player-----------------------*/
	private function disparo():Void
	{
		if (FlxG.keys.justPressed.X && framesEntreBala >= 10)
		{
			var nuevaBala = new Bala(x + width, y + height / 2, laser);
			if (misil && framesEntreMisil >= 50)
			{
				var	nuevoMisil = new Misil(x + (width / 2), y + height / 2);
				misilArray.add(nuevoMisil);
				framesEntreMisil = 0;
			}
			balaArray.add(nuevaBala);
			framesEntreBala = 0;
		}
	}
	
	private function movimiento():Void 
	{
		if (FlxG.keys.pressed.UP)
		{
			velocity.y -= speed;
			if(shield)
				animation.play("moveUpS");
			else
				animation.play("moveUp");
		}
		if (FlxG.keys.pressed.DOWN)
		{
			velocity.y += speed;
			if (shield)
				animation.play("moveDownS");
			else
				animation.play("moveDown");
		}
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x -= speed;
			if (shield)
				animation.play("moveBackwardsS");
			else
				animation.play("moveBackwards");
				
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x += speed;
			if (shield)
				animation.play("moveForwardS");
			else
				animation.play("moveForward");		
		}
	}
	
	private function checkBoundaries():Void
	{
		if (x > camera.scroll.x + FlxG.width - width)
			x = camera.scroll.x + FlxG.width - width;
		if (x < camera.scroll.x)
			x = camera.scroll.x;
		if (y > FlxG.height - 24 - height || y < 0)
		{
			preKill();
		}
	}
	
	public function preKill():Void
	{
		if (state == State.Alive)
		{
			animation.play("explode");
			state = State.Exploding;
		}
	}
	
	override public function kill():Void
	{
		super.kill();
		
		state = State.Destroyed;
		if (vidas == 0)
		{	
			Reg.gameOver = true;
			if (Reg.score > Reg.highestScore)
				Reg.highestScore = Reg.score;
		}
		else
		{
			vidas--;
			reset(camera.x, FlxG.height / 2);
		}
	}
	
	override public function reset(X, Y):Void
	{
		super.reset(X, Y);
		
		state = State.Alive;
		speed = Reg.playerNormalSpeed;
		laser = false;
		misil = false;
		shield = false;
		powerUpState = 0;
	}
	
	public function get_vidas():Int 
	{
		return vidas;
	}
	
	public function get_bala():Bala 
	{
		return bala;
	}
	
	public function get_balaArray():FlxTypedGroup<Bala> 
	{
		return balaArray;
	}
	
	/*-----------------------Power Up-----------------------*/
	/*Collision*/
	public function powerUpCollision()
	{
		powerUpState++;
	}
	
	/*Speed*/
	public function doubleSpeed():Void
	{
		speed = faster;
	}
	
	public function isDoubleSpeed():Bool
	{
		if (speed == faster)
			return true;
		return false;
	}
	/*Shield*/
	public function actShield():Void
	{
		shield = true;
	}
	
	public function isShielded():Bool
	{
		return shield;
	}
	
	public function descShield():Void
	{
		shield = false;
	}
	/*Laser*/
	public function actlaser():Void
	{
		laser = true;
	}
	
	public function isLaser():Bool
	{
		return laser;
	}
	
	/*Misil*/
	public function actMisil():Void
	{
		misil = true;
	}
	public function isMisil():Bool
	{
		return misil;
	}
	
	/*State*/
	public function getPowerUpState():Int
	{
		return powerUpState;
	}
	
	public function resetPowerUpState()
	{
		powerUpState = 0;
	}
}