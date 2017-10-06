package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxRandom;
import flixel.group.FlxGroup.FlxTypedGroup;

class EnemyInmovil extends FlxSprite //Este enemigo dispara pero no se mueve
{
	private var rTime:FlxRandom;
	private var rNum:Int;
	private var posX:Int;
	private var posY:Int;
	private var normalizado:Bool;
	public var balaEne:FlxTypedGroup<BalaEne>;
	public var pwUp:FlxTypedGroup<PowerUp>;

	public function new(?X:Float=0, ?Y:Float=0, ?Normalizado:Bool=true, PwUp:FlxTypedGroup<PowerUp>)
	{
		super(X, Y);
		loadGraphic(AssetPaths.enemyInmovil__png, true, 32, 16);
		
		width = 14;
		height = 14;
		offset.set(9, 1);
		normalizado = Normalizado;
		pwUp = PwUp;
		
		animation.add("medio", [0]);
		animation.add("derecha", [1]);
		animation.add("izq", [2]);
		
		animation.add("medioP", [3]);
		animation.add("derechaP", [4]);
		animation.add("izqP", [5]);
		
		if (normalizado)
			animation.play("medio");
		else
			animation.play("medioP");
		
		rTime = new FlxRandom();
		rNum = rTime.int(2, 4);
		posX = 0;
		posY = 0;
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		actualAni();
		disparo();
	}
	
	private function actualAni():Void
	{
		if (x > Reg.playerRef.x + 15)
		{
		if (normalizado)
			animation.play("izq");
		else
			animation.play("izqP");
			posX = 11;
			posY = 3;
		}
		else if (x < Reg.playerRef.x - 15)
		{
		if (normalizado)
			animation.play("derecha");
		else
			animation.play("derechaP");
			posX = 22;
			posY = 3;
		}
		else
		{
		if (normalizado)
			animation.play("medio");
		else
			animation.play("medioP");
			posX = 16;
			posY = 0;
		}
	}
	
	private function disparo():Void 
	{
		if (Reg.timer > 1 + rNum){ 
			var newBalaEne = new BalaEne(this.x + posX, this.y + posY);
			balaEne.add(newBalaEne);
		}
		
	}
	override public function destroy():Void
	{
		super.destroy();
		
		FlxG.sound.play(AssetPaths.enemyExploding__wav);
		if (!normalizado)
		{
			var nuevoPowerUp = new PowerUp(x, y);
			pwUp.add(nuevoPowerUp);
		}
	}
}