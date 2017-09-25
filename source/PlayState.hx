package;

import entities.Player;
import entities.Bala;
import entities.EnemyInmovil;
import entities.EnemyPerseguidor;
import entities.EnemyCoseno;
import flixel.FlxState;
import flixel.FlxG;

class PlayState extends FlxState
{
	private var player:Player;
	
	override public function create():Void
	{
		super.create();
		player = new Player(10, FlxG.height / 2);
		add(player);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}