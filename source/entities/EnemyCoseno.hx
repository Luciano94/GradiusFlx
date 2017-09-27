package entities;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Aleman5
 */
class EnemyCoseno extends FlxSprite 
{ // Se llama 'coseno' porque el patrón que va a seguir va a ser el del 'coseno'
  // https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Cosine.svg/350px-Cosine.svg.png
	
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		//loadGraphic(AssetPaths."NombreDelEnemy");
		
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
	}
}