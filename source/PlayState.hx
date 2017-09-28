package;

import entities.Guide;
import entities.Options;
import entities.PowerUp;
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
	private var option:Options;
	public var playerBalas:FlxTypedGroup<Bala>;
	private var background:FlxSprite;	// Temporary background.
	private var guide: FlxSprite;
	private var pwUp:FlxTypedGroup<PowerUp>;
	
	override public function create():Void
	{
		super.create();
		/*PLAYER*/
		playerBalas = new FlxTypedGroup<Bala>();
		player = new Player(10, FlxG.height / 2, playerBalas);
		/*Backgraund*/
		background = new FlxSprite(0, 0, AssetPaths.background__png);
		/*Power UP*/
		pwUp = new FlxTypedGroup<PowerUp>();
		pwUp.add(new PowerUp(100, 100));
		pwUp.add(new PowerUp(200, 100));
		/*CAMERA*/
		guide = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		guide.makeGraphic(1, 1, 0x00000000);
		guide.velocity.x = Reg.cameraSpeed;
		FlxG.camera.follow(guide);
		/*ADD*/
		add(guide);
		add(background);
		add(playerBalas);
		add(player);
		add(pwUp);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		/*Player*/
		playerTriggered();
		/*Power UP*/
		sistemaPowerUp();
		/*Collision*/
		colEnemyPared();
		FlxG.overlap(pwUp, player, colPwUpPlayer);
		checkBoundaries();
	}
	/*-----------------------Collision-----------------------*/
	private function checkBoundaries():Void 
	{
		if (player.x > guide.x + FlxG.width / 2 - player.width)
			player.x = guide.x + FlxG.width / 2 - player.width;
		if (player.x < guide.x - FlxG.width / 2)
			player.x = guide.x - FlxG.width / 2;
		if (player.y > FlxG.height - player.height || player.y < 0)
			player.kill(); 
	}
	
	private function colPwUpPlayer(power: PowerUp, playa: Player)
	{
			player.powerUpCollision();
			pwUp.remove(power);
	}
	
	public function colEnemyPared() 
	{
		
	}
	/*-----------------------Player-----------------------*/
	public function playerTriggered() 
	{
		
	}
	/*-----------------------Power UP-----------------------*/
	private function sistemaPowerUp()
	{
		if (FlxG.keys.justPressed.C)
		{
			switch (player.getPowerUpState()) 
			{
				case 0:
				case 1:
					player.doubleSpeed();
					player.resetPowerUpState();
				case 2:
					option = new Options(player.x - player.width, player.y,playerBalas, player);
					add(option);
					player.resetPowerUpState();
				default:
					
			}
		}
	}
}