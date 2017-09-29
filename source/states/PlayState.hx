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
		
		/*HUD*/
		lives = new FlxText(0, 216, 256, "Lives: ", 8);
		score = new FlxText(0, 216, 256, "Score: ", 8);
		highestScore = new FlxText(0, 216, 256, "Best: ", 8);
		paused = new FlxText(0, FlxG.height / 2, 256, "Paused", 8);
		gameOver = new FlxText(0, FlxG.height / 2, 256, "Game Over", 8);
		
		lives.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.LEFT);
		score.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER);
		highestScore.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.RIGHT);
		paused.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER);
		gameOver.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER);
		
		paused.visible = false;
		gameOver.visible = false;
		
		lives.scrollFactor.x = 0;
		score.scrollFactor.x = 0;
		highestScore.scrollFactor.x = 0;
		
		/*ADD*/
		add(guide);
		add(background);
		add(playerBalas);
		add(player);
		add(pwUp);
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
		}
		
		lives.text = "Lives: " + player.vidas;
		score.text = "Score: " + Reg.score;
		highestScore.text = "Best: " + Reg.highestScore;
		
		if (FlxG.keys.justPressed.ENTER && !Reg.gameOver)
		{
			Reg.paused = !Reg.paused;
			paused.visible = !paused.visible;
		}
	}
	/*-----------------------Collision-----------------------*/
	
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