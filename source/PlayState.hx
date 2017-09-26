package;

import entities.Options;
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
	private var option:Options;
	
	override public function create():Void
	{
		super.create();
		player = new Player(10, FlxG.height / 2);
		//option = new Options(10, FlxG.height / 2);
		add(player);
		//add(option);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}