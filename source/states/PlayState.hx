package states;

import entities.Boss;
import entities.BalaBoss;
import entities.Guide;
import entities.Misil;
import entities.Obstacle;
import entities.Options;
import entities.PowerUp;
import entities.Player;
import entities.Bala;
import entities.BalaEne;
import entities.EnemyInmovil;
import entities.EnemyPerseguidor;
import entities.EnemyCoseno;
import entities.PwUpBar;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.ui.FlxBar;

class PlayState extends FlxState
{
	/*Player*/
	private var player:Player;
	public var playerBalas:FlxTypedGroup<Bala>;
	/*PowerUps*/
	private var opt1:Options;
	private var opt2:Options;
	private var op1:Bool;
	private var op2:Bool;
	private var pwUp:FlxTypedGroup<PowerUp>;
	private var powerUpState:Int;
	public var playerMisiles:FlxTypedGroup<Misil>;
	public var pwUpBar:PwUpBar;
	/*Text*/
	private var lives:FlxText;
	private var score:FlxText;
	private var highestScore:FlxText;
	private var paused:FlxText;
	private var gameOver:FlxText;
	private var gameCleared:FlxText;
	/*Camera*/
	private var guide:FlxSprite;
	/*Enemies*/
	public var enemyPerseguidor:FlxTypedGroup<EnemyPerseguidor>;
	public var enemyCoseno:FlxTypedGroup<EnemyCoseno>;
	public var enemyInmovil:FlxTypedGroup<EnemyInmovil>;
	public var enemyInmovilBalas:FlxTypedGroup<BalaEne>;
	/*Obstacles*/
	private var obstacles:FlxTypedGroup<Obstacle>;
	private var  bosito:Boss;
	private var bossBalas:FlxTypedGroup<BalaBoss>;
	private var loader:FlxOgmoLoader;
	private var bositoBar:FlxBar;
	
	/*Tilemap*/
	private var tilemap:FlxTilemap;
	
	override public function create():Void
	{
		super.create();
		
		/*TILEMAP*/
		FlxG.worldBounds.set(0, 0, 7680, 240);
		loader = new FlxOgmoLoader(AssetPaths.Level__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "Tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		for (i in 1...19)	// Find a way to avoid hard-coding this.
		{
			tilemap.setTileProperties(i, FlxObject.ANY);
		}
		
		/*PLAYER*/
		playerBalas = new FlxTypedGroup<Bala>();
		playerMisiles = new FlxTypedGroup<Misil>();
		
		/*Power UP*/
		pwUpBar = new PwUpBar(1, 180);
		op1 = false;
		op2 = false;
		pwUp = new FlxTypedGroup<PowerUp>();

		/*CAMERA*/
		guide = new FlxSprite(FlxG.width / 2, FlxG.height / 2);
		guide.makeGraphic(1, 1, 0x00000000);
		guide.velocity.x = Reg.cameraSpeed;
		FlxG.camera.follow(guide);
		
		/*ENEMIES*/
		enemyPerseguidor = new FlxTypedGroup<EnemyPerseguidor>();
		enemyCoseno = new FlxTypedGroup<EnemyCoseno>();
		enemyInmovil = new FlxTypedGroup<EnemyInmovil>();
		enemyInmovilBalas = new FlxTypedGroup<BalaEne>();
		bossBalas = new FlxTypedGroup<BalaBoss>();
		
		/*OBSTACLES*/
		obstacles = new FlxTypedGroup<Obstacle>();
		
		/*TEXT*/
		lives = new FlxText(0, 225, 256, "Lives: ", 8);
		score = new FlxText(0, 225, 256, "Score: ", 8);
		highestScore = new FlxText(0, 225, 256, "Highest: ", 8);
		paused = new FlxText(0, FlxG.height / 2, 256, "Paused", 12);
		gameOver = new FlxText(0, FlxG.height / 2, 256, "Game Over", 12);
		gameCleared = new FlxText(0, FlxG.height / 2, 256, "Game Cleared", 12);
		
		lives.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.LEFT);
		score.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.CENTER);
		highestScore.setFormat(null, 8, FlxColor.WHITE, FlxTextAlign.RIGHT);
		paused.setFormat(null, 12, FlxColor.WHITE, FlxTextAlign.CENTER);
		gameOver.setFormat(null, 12, FlxColor.WHITE, FlxTextAlign.CENTER);
		gameCleared.setFormat(null, 12, FlxColor.WHITE, FlxTextAlign.CENTER);
		
		paused.visible = false;
		gameOver.visible = false;
		highestScore.visible = false;
		gameCleared.visible = false;
		
		lives.scrollFactor.x = 0;
		score.scrollFactor.x = 0;
		highestScore.scrollFactor.x = 0;
		paused.scrollFactor.x = 0;
		gameOver.scrollFactor.x = 0;
		
		/*ADD*/
		add(tilemap);
		loader.loadEntities(entityCreator, "Entities");
		
		/*BOSS*/
		bositoBar = new FlxBar(0, 0, FlxBarFillDirection.LEFT_TO_RIGHT, 30, 5, bosito, "life", 0, 100, true);
		
		/*ADD*/
		add(guide);
		add(playerBalas);
		add(playerMisiles);
		add(bossBalas);
		add(pwUp);
		add(pwUpBar);
		add(enemyPerseguidor);
		add(enemyInmovil);
		add(enemyInmovilBalas);
		add(enemyCoseno);
		add(obstacles);
		add(bositoBar);
		add(lives);
		add(score);
		add(highestScore);
		add(paused);
		add(gameOver);
		
		FlxG.sound.play(AssetPaths.theme__wav, 1, true);
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
				var cosineEnemy = new EnemyCoseno(x, y, pwUp);
				enemyCoseno.add(cosineEnemy);
			case "StaticEnemies":
				var staticEnemy = new EnemyInmovil(x, y, pwUp, enemyInmovilBalas);
				enemyInmovil.add(staticEnemy);
			case "ChasingEnemies":
				var chasingEnemy = new EnemyPerseguidor(x, y, pwUp);
				enemyPerseguidor.add(chasingEnemy);	
			case "Obstacles":
				var obstacle = new Obstacle(x, y, AssetPaths.obstacle__png);
				obstacles.add(obstacle);
			case "Boss":
				bosito = new Boss(x, y, bossBalas);
				add(bosito);
		}
	}

	override public function update(elapsed:Float):Void
	{
		if (!Reg.gameOver && !Reg.paused)
		{
			super.update(elapsed);
			
			/*Camera*/
			if (camera.scroll.x >= 7680 - FlxG.width)
			{
				guide.velocity.x = 0;
				player.setBoss();
				if (op1) opt1.setBoss();
				if (op2) opt2.setBoss();
				pwUpBar.velocity.x = 0;
			}
			
			/*Power UP*/
			sistemaPowerUp();
			checkOptions();
			
			bositoBar.x = bosito.x + 16;
			bositoBar.y = bosito.y + 5;
			
			/*Collisions*/
			FlxG.overlap(pwUp, player, colPwUpPlayer);
			FlxG.overlap(player.get_balaArray(), enemyInmovil, damageEnemyInmovil);
			FlxG.overlap(player.get_balaArray(), enemyCoseno, damageEnemyCoseno);
			FlxG.overlap(player.get_balaArray(), enemyPerseguidor, damageEnemyPerseguidor);
			FlxG.overlap(player.get_balaArray(), obstacles, destroyObstacle);
			FlxG.overlap(player.get_balaArray(), bosito, damageBosito);
			FlxG.overlap(player.get_misilArray(), enemyInmovil, damageEnemyInmovil);
			FlxG.overlap(player.get_misilArray(), enemyCoseno, damageEnemyCoseno);
			FlxG.overlap(player.get_misilArray(), enemyPerseguidor, damageEnemyPerseguidor);
			FlxG.overlap(player.get_misilArray(), obstacles, destroyObstacle);
			FlxG.overlap(enemyInmovil, player, enemyPlayerCollision);
			FlxG.overlap(enemyCoseno, player, enemyPlayerCollision);
			FlxG.overlap(enemyPerseguidor, player, enemyPlayerCollision);
			FlxG.overlap(bosito, player, colBossPlayer);
			FlxG.overlap(obstacles, player, obstaclePlayerCollision);
			FlxG.collide(tilemap, player, tilemapPlayerCollision);
			FlxG.overlap(bossBalas, player, colBulletPlayer);
			FlxG.overlap(enemyInmovilBalas, player, colBulletEnePlayer);
			
		}
		
		lives.text = "Lives: " + player.vidas;
		score.text = "Score: " + Reg.score;
		highestScore.text = "Highest: " + Reg.highestScore;
		
		if (Reg.highestScore > 0)
			highestScore.visible = true;
		
		if (FlxG.keys.justPressed.ENTER && !Reg.gameOver)
		{
			Reg.paused = !Reg.paused;
			paused.visible = !paused.visible;
			FlxG.sound.play(AssetPaths.pause__wav);
		}
		
		if (Reg.gameOver)
		{
			gameOver.visible = true;		
		}
		
		if (Reg.gameCleared)
			gameCleared.visible = true;
	}
	/*-----------------------Collision-----------------------*/
	private function colBulletPlayer(shot: BalaBoss , playa: Player )
	{
		shot.destroy();
		if (player.isShielded())
			player.descShield();
		else
			player.preKill();
	}
	
	private function colBulletEnePlayer(shot: BalaEne , playa: Player )
	{
		shot.destroy();
		if (player.isShielded())
			player.descShield();
		else
			player.preKill();
	}
	/*Tilemap*/
	
	private	function tilemapPlayerCollision(tilemap:FlxTilemap, player:Player):Void
	{
		player.preKill();
	}
	/*PwUp*/
	
	private function colPwUpPlayer(power:PowerUp, playa:Player):Void
	{
		playa.powerUpCollision();
		power.destroy();
		pwUp.remove(power, true);
	}
	/*Enemies*/
	
	private	function enemyPlayerCollision(enemy, player:Player):Void
	{
		enemy.destroy();
		player.preKill();
	}
	
	private function obstaclePlayerCollision(obstacle:Obstacle, player:Player)
	{
		obstacles.remove(obstacle, true);
		obstacle.destroy();
		if (player.isShielded())
			player.descShield();
		else
			player.preKill();		
	}
	
	private function damageEnemyInmovil(shot, enemy:EnemyInmovil):Void
	{
		Reg.score += 10;
		shot.destroy();
		enemyInmovil.remove(enemy, true);
		enemy.destroy();
	}
	
	private function damageEnemyCoseno(shot, enemy:EnemyCoseno):Void
	{
		Reg.score += 20;
		shot.destroy();
		if (player.isLaser())
		{
			enemyCoseno.remove(enemy, true);
			enemy.destroy();
		}
		else
	    	enemy.getDamage();		
	}   
	
	private function damageEnemyPerseguidor(shot, enemy:EnemyPerseguidor):Void 
	{
		Reg.score += 30;
		shot.destroy();
		enemyPerseguidor.remove(enemy);
		enemy.destroy();
	}
	
	private function destroyObstacle(shot, obstacle:Obstacle):Void
	{
		Reg.score += 5;
		shot.destroy();
		obstacles.remove(obstacle);
		obstacle.destroy();
	}
	
	private function damageBosito(shot:Bala, bosito:Boss):Void
	{
		shot.destroy();
		bosito.getDamage();
	}
	
	private function colBossPlayer(bos:Boss, player:Player):Void
	{
		player.preKill();
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
		
		if (FlxG.keys.justPressed.Z)	//This should probably be a player method.
		{
			switch (player.getPowerUpState()) 
			{
				case 1:
					FlxG.sound.play(AssetPaths.powerUpActivation__wav);
					player.resetPowerUpState();
					player.doubleSpeed();
				case 2:
					FlxG.sound.play(AssetPaths.powerUpActivation__wav);
					player.resetPowerUpState();
					player.actlaser();
				case 3:
					FlxG.sound.play(AssetPaths.powerUpActivation__wav);
					player.resetPowerUpState();
					player.actMisil();
				case 4:
					FlxG.sound.play(AssetPaths.powerUpActivation__wav);
					player.resetPowerUpState();
					if (op1 && !op2)
					{
						opt2 = new Options(opt1.x - opt1.width, opt1.y, playerBalas, playerMisiles, opt1);
						op2 = true;
						add(opt2);
					}	
					else
					{
						if (!op1)
						{
							opt1 = new Options (player.x - player.width, player.y, playerBalas, playerMisiles, player);
							op1 = true;
							add(opt1);
						}
					}
				case 5:
					FlxG.sound.play(AssetPaths.powerUpActivation__wav);
					player.resetPowerUpState();
					player.actShield();
				default:
			}
		}
	}
	
	private function checkOptions():Void 
	{
		if (op1 && player.getState())
		{
			opt1.destroy();
			op1 = false;
		}
		if (op2 && player.getState())
		{
			opt2.destroy();
			op2 = false;
		}
	}
}