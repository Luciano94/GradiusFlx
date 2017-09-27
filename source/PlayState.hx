package;

import entities.Guide;
import entities.Options;
import entities.Player;
import entities.Bala;
import entities.BalaEne;
import entities.EnemyInmovil;
import entities.EnemyPerseguidor;
import entities.EnemyCoseno;
import entities.Vidas;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState
{
	private var player:Player;
	private var guide:Guide;
	private var option:Options;
	private var vidas:FlxTypedGroup<Vidas>;
	public var playerBalas:FlxTypedGroup<Bala>;
	
	
	override public function create():Void
	{
		super.create();

		player = new Player(10, FlxG.height / 2, playerBalas);
		guide = new Guide(FlxG.width / 2, FlxG.height / 2);
		vidas = new FlxTypedGroup<Vidas>();
		playerBalas = new FlxTypedGroup<Bala>();
		
		camera.follow(guide);
		
		add(guide);
		add(player);
		add(playerBalas);
		
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