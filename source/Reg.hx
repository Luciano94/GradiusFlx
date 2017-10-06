package;
import entities.Player;

class Reg 
{	// Cosas de Camara
	static public var cameraSpeed:Int = 50;
	// Score
	static public var score:Int = 0;
	static public var highestScore:Int = 0;
	// Game Over & Pause
	static public var gameOver:Bool = false;
	static public var paused:Bool = false;
	// Cosas de Player
	static public var playerNormalSpeed:Int = 100;
	static public var playerPowerUpSpeed:Int = 150;
	static inline public var playerMaxLives:Int = 3;
	static public var playerBalaSpeed:Int = 250;
	static public var playerFramesEntreBala:Int = 0;
	static public var playerRef:Player;
	static inline public var numberOfPowerUps:Int = 5;
	// Cosas de Boss
	static public var bossNormalSpeed:Int = 20;
	static public var bossFramesEntreBalas:Int = 0;
	static public var bossBerserkSpeed:Int = 40;
	// Cosas de EnemyInmovil
	static public var enemyBalaSpeed:Int = 60;
	static public var timer:Float = 0;
	// Cosas de EnemyPerseguidor
	static public var enemySpeedX:Int = 25; 
	static public var enemySpeedY:Int = 40;
	// Cosas de EnemyCoseno
	static public var enemyCSpeedX:Int = 30;
	static public var enemyCSpeedY:Int = -120;
	static public var enemyCShp:Int = 2;
}