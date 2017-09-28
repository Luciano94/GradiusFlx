package entities;

import entities.Guide;
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
	private var powerUpState:Int;
	public var bala(get, null):Bala;
	public var guide:Guide;
	
	public function new(?X:Float=0, ?Y:Float=0, playerBalaArray:FlxTypedGroup<Bala>) 
	{
		super(X, Y);
		
		loadGraphic(AssetPaths.spaceship__png, true, 32, 24);
		balaArray = playerBalaArray;
		speed = Reg.playerNormalSpeed;
		vidas = Reg.playerMaxLives;
		framesEntreBala = Reg.playerFramesEntreBala;
		powerUpState = 0;
		guide = new Guide(FlxG.width / 2, FlxG.height / 2);
		
		camera.follow(guide);
		FlxG.state.add(guide);
		
		animation.add("idle", [0, 1, 2], 6, true);
		animation.add("moveUp", [5]);
		animation.add("moveDown", [6]);
		animation.add("moveBackwards", [4]);
		animation.add("moveForward", [3]);
		
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		velocity.set(Reg.cameraSpeed, 0);
		framesEntreBala++;
		animation.play("idle");
		
		movimiento();
		disparo();
		checkBoundaries();
	}
	
	private function disparo() 
	{
		if (FlxG.keys.justPressed.SPACE && framesEntreBala >= 5)
		{
			var nuevaBala = new Bala(x + width, y + height / 2);
			balaArray.add(nuevaBala);
			framesEntreBala = 0;
		}
	}
	
	private function powerUpCollision()
	{
		powerUpState++;
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
		if (x > guide.x + FlxG.width / 2 - width)
			x = guide.x + FlxG.width / 2 - width;
		if (x < guide.x - FlxG.width / 2)
			x = guide.x - FlxG.width / 2;
		if (y > FlxG.height - height || y < 0)
			kill(); 
	}
	
	public function get_vidas():Int 
	{
		return vidas;
	}
	
		public function get_bala():Bala 
	{
		return bala;
	}
}