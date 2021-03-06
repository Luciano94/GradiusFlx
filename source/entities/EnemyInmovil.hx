package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxG;
import flixel.math.FlxRandom;

class EnemyInmovil extends FlxSprite //Este enemigo dispara pero no se mueve
{
	private var rTime:FlxRandom;
	private var rNum:Int;
	private var posX:Int;
	private var posY:Int;
	private var timeBtwLaser:Int;
	private var normalizado:Bool;
	private var proba:FlxRandom;
	public var balaEne:FlxTypedGroup<BalaEne>;
	public var pwUp:FlxTypedGroup<PowerUp>;

	public function new(?X:Float=0, ?Y:Float=0, PwUp:FlxTypedGroup<PowerUp>, EnemyInmovilBalas:FlxTypedGroup<BalaEne>)
	{
		super(X, Y);
		loadGraphic(AssetPaths.enemyInmovil__png, true, 32, 16);
		
		balaEne = EnemyInmovilBalas;
		width = 14;
		height = 14;
		offset.set(9, 1);
		pwUp = PwUp;
		timeBtwLaser = 0;
		
		proba = new FlxRandom();
		normalizado = proba.bool(70);
		
		animation.add("medio", [0]);
		animation.add("medioP", [3]);
		
		if (normalizado)
			animation.play("medio");
		else
			animation.play("medioP");
		
		rTime = new FlxRandom();
		rNum = rTime.int(2, 4);
		posX = -1;
		posY = -240;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		timeBtwLaser++;
		if (timeBtwLaser >= 300)
		{
			timeBtwLaser = 0;
			disparo();
		}
	}
	
	private function disparo():Void 
	{
		var newBalaEne = new BalaEne(x, y);
		balaEne.add(newBalaEne);
	}
	
	override public function destroy():Void
	{
		super.destroy();
		
		FlxG.sound.play(AssetPaths.enemyExploding__wav);
		if (!normalizado)
		{
			var nuevoPowerUp = new PowerUp(x, y - 15);
			pwUp.add(nuevoPowerUp);
		}
	}
}