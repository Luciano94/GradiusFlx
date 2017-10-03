package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxRandom;

class EnemyInmovil extends FlxSprite //Este enemigo dispara pero no se mueve
{
	private var rTime:FlxRandom;
	private var rNum:Int;
	private var posX:Int;
	private var posY:Int;
	public var balaEne(get, null):BalaEne;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		
		loadGraphic(AssetPaths.enemyInmovil__png, true, 32, 16);
		
		width = 14;
		height = 14;
		offset.set(9, 1);
		
		animation.add("medio", [0]);
		animation.add("derecha", [1]);
		animation.add("izq", [2]);
		animation.play("medio");
		
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
			animation.play("izq");
			posX = 11;
			posY = 3;
		}
		else if (x < Reg.playerRef.x - 15)
		{
			animation.play("derecha");
			posX = 22;
			posY = 3;
		}
		else
		{
			animation.play("medio");
			posX = 16;
			posY = 0;
		}
	}
	
	private function disparo():Void 
	{
		if (Reg.timer > 3 + rNum) 
			balaEne = new BalaEne(this.x + posX, this.y + posY); // Se va a modificar X|Y de acuerdo al tamaño del enemy
		
	}
	
	public function get_balaEne():BalaEne 
	{
		return balaEne;
	}
}