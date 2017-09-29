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
	private var speed:Int;
	private var faster:Int;
	public var vidas(get, null):Int;
	private var framesEntreBala:Int;
	private var balaArray:FlxTypedGroup<Bala>;
	private var powerUpState:Int;
	public var bala(get, null):Bala;
	private var state:State;
	
	public function new(?X:Float=0, ?Y:Float=0, playerBalaArray:FlxTypedGroup<Bala>) 
	{
		super(X, Y);
		/*Graphic*/
		loadGraphic(AssetPaths.spaceship__png, true, 32, 24);
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
		powerUpState = 0;
		faster = speed * 2;
		/*Animations*/
		animation.add("idle", [0, 1, 2], 6, true);
		animation.add("moveUp", [5]);
		animation.add("moveDown", [6]);
		animation.add("moveBackwards", [4]);
		animation.add("moveForward", [3]);
		animation.add("explode", [7, 8, 9], 6, false);
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		switch (state) 
		{
			case State.Alive:
				velocity.set(Reg.cameraSpeed, 0);
				framesEntreBala++;
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
	
	private function checkBoundaries():Void
	{
		if (x > camera.scroll.x + FlxG.width - width)
			x = camera.scroll.x + FlxG.width - width;
		if (x < camera.scroll.x)
			x = camera.scroll.x;
		if (y > FlxG.height - height || y < 0)
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
			Reg.gameOver = true;
		else
		{
			vidas--;
			reset(10, FlxG.height / 2);
		}
	}
	
	override public function reset(X, Y):Void
	{
		super.reset(X, Y);
		
		state = State.Alive;
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
	public function powerUpCollision():Void
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
	
	public function resetPowerUpState():Void
	{
		powerUpState = 0;
	}
}