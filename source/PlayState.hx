package;

import entities.Guide;
import entities.Options;
import entities.Player;
import entities.Bala;
import entities.BalaEne;
import entities.EnemyInmovil;
import entities.EnemyPerseguidor;
import entities.EnemyCoseno;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState
{
	private var player:Player;
	//private var guide:Guide;
	private var option:Options;
	public var playerBalas:FlxTypedGroup<Bala>;
	
	
	override public function create():Void
	{
		super.create();

		playerBalas = new FlxTypedGroup<Bala>();
		player = new Player(10, FlxG.height / 2, playerBalas);
		//guide = new Guide(FlxG.width / 2, FlxG.height / 2);
		
		//add(guide);
		add(playerBalas);
		add(player);
		
		
		//option = new Options(10, FlxG.height / 2);
		//add(option);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		playerTriggered();
		colEnemyPared();
	}
	
	public function colEnemyPared() 
	{
		
	}
	
	public function playerTriggered() 
	{
		
	}
}