package states;

import entities.Guide;
import entities.Misil;
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
	private var opt1:Options;
	private var opt2:Options;
	private var powerUpState:Int;
	public var playerBalas:FlxTypedGroup<Bala>;
	public var playerMisiles:FlxTypedGroup<Misil>;
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
		playerMisiles = new FlxTypedGroup<Misil>();
		player = new Player(10, FlxG.height / 2, playerBalas, playerMisiles);
		Reg.playerRef = player;
		
		/*Background*/
		background = new FlxSprite(0, 0, AssetPaths.background__png);
		
		/*Power UP*/
		pwUp = new FlxTypedGroup<PowerUp>();
		pwUp.add(new PowerUp(100, 100));
		pwUp.add(new PowerUp(200, 100));
		pwUp.add(new PowerUp(250, 150));
		pwUp.add(new PowerUp(220, 150));
		
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
		lives = new FlxText(0, 216, 256, "Lives: ", 8);
		score = new FlxText(0, 216, 256, "Score: ", 8);
		highestScore = new FlxText(0, 216, 256, "Best: ", 8);
		paused = new FlxText(0, FlxG.height / 2, 256, "Paused", 12);
		gameOver = new FlxText(0, FlxG.height / 2, 256, "Game Over", 12);
		
		lives.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.LEFT);
		score.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER);
		highestScore.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.RIGHT);
		paused.setFormat(null, 12, FlxColor.WHITE, FlxTextAlign.CENTER);
		gameOver.setFormat(null, 12, FlxColor.WHITE, FlxTextAlign.CENTER);
		
		paused.visible = false;
		gameOver.visible = false;
		highestScore.visible = false;
		
		lives.scrollFactor.x = 0;
		score.scrollFactor.x = 0;
		highestScore.scrollFactor.x = 0;
		paused.scrollFactor.x = 0;
		gameOver.scrollFactor.x = 0;
		
		/*ADD*/
		add(guide);
		add(background);
		add(playerBalas);
		add(playerMisiles);
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
			
			/*Power UP*/
			sistemaPowerUp();
			
			/*Collisions*/
			FlxG.overlap(pwUp, player, colPwUpPlayer);
			FlxG.overlap(player.balaArray, enemyInmovil, damageEnemyInmovil);
			FlxG.overlap(player.balaArray, enemyCoseno, damageEnemyCoseno);
			FlxG.overlap(player.balaArray, enemyPerseguidor, damageEnemyPerseguidor);
			if (FlxG.overlap(enemyInmovil, player))
				player.preKill();
			if (FlxG.overlap(enemyPerseguidor, player))
				player.preKill();
			if (FlxG.overlap(enemyCoseno, player))
				player.preKill();
			
			
		}
		
		lives.text = "Lives: " + player.vidas;
		score.text = "Score: " + Reg.score;
		highestScore.text = "Best: " + Reg.highestScore;
		
		if (Reg.highestScore > 0)
			highestScore.visible = true;
		
		if (FlxG.keys.justPressed.ENTER && !Reg.gameOver)
		{
			Reg.paused = !Reg.paused;
			paused.visible = !paused.visible;
		}
		
		if (Reg.gameOver)
		{
			gameOver.visible = true;
		}
	}

	/*-----------------------Collision-----------------------*/
	
	private function colPwUpPlayer(power:PowerUp, playa:Player):Void
	{
		player.powerUpCollision();
		power.kill();
	}
	
	private function damageEnemyInmovil(shot:Bala, enemy:EnemyInmovil):Void
	{
		Reg.score += 10;
		shot.destroy();
		enemy.destroy();
	}
	
	private function damageEnemyCoseno(shot:Bala, enemy:EnemyCoseno):Void
	{
		Reg.score += 20;
		shot.destroy();
		enemy.getDamage();
	}
	
	private function damageEnemyPerseguidor(shot:Bala, enemy:EnemyPerseguidor):Void 
	{
		Reg.score += 30;
		shot.destroy();
		if (player.isLaser)
			enemy.destroy();
		else
			enemy.getDamage();
	}
	
	/*-----------------------Power UP-----------------------*/
	private function sistemaPowerUp()
	{
		if (FlxG.keys.justPressed.C)
		{
			switch (player.getPowerUpState()) 
			{
				case 1:
					player.resetPowerUpState();
					player.doubleSpeed();
				case 2:
					player.resetPowerUpState();
					player.actlaser();
				case 3:
					player.resetPowerUpState();
					player.actMisil();
				case 4:
					player.resetPowerUpState();
					if (opt1 != null)
					{
						opt2 = new Options (opt1.x - opt1.width, opt1.y, playerBalas, playerMisiles, opt1);
						add(opt2);
					}	
					else
					{
						opt1 = new Options (player.x - player.width, player.y, playerBalas, playerMisiles, player);
						add(opt1);
					}
				default:
			}
		}
	}
}