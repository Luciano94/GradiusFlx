package states;

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
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	private var player:Player;
	private var option:Options;
	public var playerBalas:FlxTypedGroup<Bala>;
	private var background:FlxSprite;	// Temporary background.
	private var guide:FlxSprite;
	private var pwUp:FlxTypedGroup<PowerUp>;
	public var enemyPerseguidor:FlxTypedGroup<EnemyPerseguidor>;
	public var enemyInmovil:FlxTypedGroup<EnemyInmovil>;
	public var enemyCoseno:FlxTypedGroup<EnemyCoseno>;
	public var eP:EnemyPerseguidor;
	public var eI:EnemyInmovil;
	public var eC:EnemyCoseno;
	private var lives:FlxText;
	private var score:FlxText;
	private var highestScore:FlxText;
	private var paused:FlxText;
	private var gameOver:FlxText;
	
	override public function create():Void
	{
		super.create();
		/*PLAYER*/
		playerBalas = new FlxTypedGroup<Bala>();
		player = new Player(10, FlxG.height / 2, playerBalas);
		Reg.playerRef = player;
		
		/*Background*/
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
		
		/*ENEMY*/
		eP = new EnemyPerseguidor(200, 200);
		eI = new EnemyInmovil(100, 200);
		eC = new EnemyCoseno(220, 150);
		enemyPerseguidor = new FlxTypedGroup<EnemyPerseguidor>();
		enemyInmovil = new FlxTypedGroup<EnemyInmovil>();
		enemyCoseno = new FlxTypedGroup<EnemyCoseno>();

		
		/*HUD*/
		lives = new FlxText(0, 0, 256, "Lives: ", 8);
		score = new FlxText(0, 0, 256, "Score: ", 8);
		highestScore = new FlxText(0, 0, 256, "Best: ", 8);
		paused = new FlxText(0, 0, 256, "Paused", 8);
		gameOver = new FlxText(0, 0, 256, "Game Over", 8);
		
		lives.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.LEFT);
		score.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER);
		highestScore.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.RIGHT);
		paused.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER);
		gameOver.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER);
		
		paused.visible = false;
		gameOver.visible = false;
		
		lives.scrollFactor.x = 0;
		
		/*ADD*/
		add(guide);
		add(background);
		add(playerBalas);
		add(player);
		add(pwUp);
		enemyPerseguidor.add(eP);
		enemyInmovil.add(eI);
		enemyCoseno.add(eC);
		add(enemyPerseguidor);
		add(enemyInmovil);
		add(enemyCoseno);
		add(lives);
		add(score);
		add(highestScore);
		add(paused);
		add(gameOver);
	}

	override public function update(elapsed:Float):Void
	{
		if (!Reg.gameOver && !Reg.paused)
		{
			super.update(elapsed);
			
			/*Player*/
			playerTriggered();
			
			/*Power UP*/
			sistemaPowerUp();
			
			/*Collision*/
			colEnemyPared();
			FlxG.overlap(pwUp, player, colPwUpPlayer);
			if (FlxG.overlap(enemyInmovil, player))
				player.kill();
			if (FlxG.overlap(enemyPerseguidor, player))
				player.kill();
			if (FlxG.overlap(enemyCoseno, player))
				player.kill();
			checkBoundaries();
		}
		
		lives.text += player.vidas;
		score.text += Reg.score;
		highestScore.text += Reg.highestScore;
		
		if (FlxG.keys.justPressed.ENTER && !Reg.gameOver)
		{
			Reg.paused = !Reg.paused;
			paused.visible = !paused.visible;
		}
	}
	/*-----------------------Collision-----------------------*/
	private function checkBoundaries():Void // Consider adding this checking to the Player class.
	{
		if (player.x > guide.x + FlxG.width / 2 - player.width)
			player.x = guide.x + FlxG.width / 2 - player.width;
		if (player.x < guide.x - FlxG.width / 2)
			player.x = guide.x - FlxG.width / 2;
		if (player.y > FlxG.height - player.height || player.y < 0)
			player.kill(); 
	}
	
	private function colPwUpPlayer(power:PowerUp, playa:Player):Void
	{
		player.powerUpCollision();
		pwUp.remove(power);
	}
	
	public function colEnemyPared():Void
	{
		
	}
	/*-----------------------Player-----------------------*/
	public function playerTriggered():Void
	{
		
	}
	/*-----------------------Power UP-----------------------*/
	private function sistemaPowerUp():Void
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
					option = new Options(player.x - player.width, player.y, playerBalas, player);
					add(option);
					player.resetPowerUpState();
				default:
					
			}
		}
	}
}