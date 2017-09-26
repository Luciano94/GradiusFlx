package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxRandom;
import neko.Random;

/**
 * ...
 * @author Aleman5
 */
class EnemyInmovil extends FlxSprite //Este enemigo dispara pero no se mueve
{
	private var rTime:FlxRandom;
	private var rNum:Int;
	public var balaEne(get, null):BalaEne;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		
		//loadGraphic(AssetPaths."NombreDelEnemy");
		rTime = new FlxRandom();
		rNum = rTime.int(3, 5);
	}
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		disparo();

	}
	
	function disparo():Void 
	{
		if (Reg.timer > 3+rNum) 
			balaEne = new BalaEne(this.x, this.y); // Se va a modificar de acuerdo al tamaño del mismo
	}
	
	function get_balaEne():BalaEne 
	{
		return balaEne;
	}
}