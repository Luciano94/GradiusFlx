package states;

import entities.Boss;
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
import entities.PwUpBar;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	/*player*/
	private var player:Player;
	public var playerBalas:FlxTypedGroup<Bala>;
	/*powerUps*/
	private var opt1:Options;
	private var opt2:Options;
	private var pwUp:FlxTypedGroup<PowerUp>;
	private var powerUpState:Int;
	public var playerMisiles:FlxTypedGroup<Misil>;
	public var pwUpBar:PwUpBar;
	/*Lvl*/
	private var background:FlxSprite;	// Temporary background.
	private var lives:FlxText;
	private var score:FlxText;
	private var highestScore:FlxText;
	private var paused:FlxText;
	private var gameOver:FlxText;
	/*Camera*/
	private var guide:FlxSprite;
	/*Enemys*/
	public var enemyPerseguidor:FlxTypedGroup<EnemyPerseguidor>;
	public var enemyInmovil:FlxTypedGroup<EnemyInmovil>;
	public var enemyCoseno:FlxTypedGroup<EnemyCoseno>;
	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	
	override public function create():Void
	{
		super.create();
		
		FlxG.worldBounds.set(0, 0, 7680, 240);
		loader = new FlxOgmoLoader(AssetPaths.Level__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 32, 24, "Tiles");
		
		/*PLAYER*/
		playerBalas = new FlxTypedGroup<Bala>();
		playerMisiles = new FlxTypedGroup<Misil>();
		
		/*Background*/
		background = new FlxSprite(0, 0, AssetPaths.background__png);
		
		/*Power UP*/
		pwUpBar = new PwUpBar(1,180);
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
		add(background);
		loader.loadEntities(entityCreator, "Entities");
		add(guide);
		add(playerBalas);
		add(playerMisiles);
		add(pwUp);
		add(pwUpBar);
		add(enemyPerseguidor);
		add(enemyInmovil);
		add(enemyCoseno);
		add(bosito);
		add(lives);
		add(score);
		add(highestScore);
		add(paused);
		add(gameOver);
	}
	
	private function entityCreator(entityName:String, entityData:Xml):Void
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		
		switch (entityName) 
		{
			case "Player":
				player = new Player(x, y, playerBalas, playerMisiles);
				Reg.playerRef = player;
				add(player);
			case "CosineEnemies":
				var cosineEnemy = new EnemyCoseno(x, y, false, pwUp);
				enemyCoseno.add(cosineEnemy);
			case "StaticEnemies":
				var staticEnemy = new EnemyInmovil(x, y, false, pwUp);
				enemyInmovil.add(staticEnemy);
			case "ChasingEnemies":
				var chasingEnemy = new EnemyPerseguidor(x, y, false, pwUp);
				enemyPerseguidor.add(chasingEnemy);	
		}
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
			FlxG.overlap(player.get_balaArray(), enemyInmovil, damageEnemyInmovil);
			FlxG.overlap(player.get_balaArray(), enemyCoseno, damageEnemyCoseno);
			FlxG.overlap(player.get_balaArray(), enemyPerseguidor, damageEnemyPerseguidor);
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
	/*PwUp*/
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
		if (player.isLaser())
			enemy.destroy();
		else
	    	enemy.getDamage();		
	}   
	private function damageEnemyPerseguidor(shot:Bala, enemy:EnemyPerseguidor):Void 
	{
		Reg.score += 30;
		shot.destroy();
		enemy.destroy();
	}
	
	/*-----------------------Power UP-----------------------*/
	private function sistemaPowerUp()
	{
			switch (player.getPowerUpState()) 
			{
				case 1:
					pwUpBar.animation.play("speed");
				case 2:
					pwUpBar.animation.play("laser");
				case 3:
					pwUpBar.animation.play("misil");
				case 4:
					pwUpBar.animation.play("option");
				case 5:
					pwUpBar.animation.play("shield");
				default:
					pwUpBar.animation.play("idle");
			}
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
				case 5:
					player.resetPowerUpState();
					player.actShield();
				default:
			}
		}
	}
}