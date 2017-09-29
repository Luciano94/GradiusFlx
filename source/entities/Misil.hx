package entities;

/**
 * ...
 * @author holis
 */

class Misil extends Bala 
{

	public function new(?X:Float=0, ?Y:Float=0, ?_laser:Bool) 
	{
		super(X, Y, _laser);
		loadGraphic(AssetPaths.Misil__png, false, 8, 8);
		velocity.set(speed, speed);
		laser = false;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
}