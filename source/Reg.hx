package;

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
	static inline public var playerMaxLives = 3;
	static public var playerBalaSpeed:Int = 250;
	static public var playerFramesEntreBala:Int = 0;
	// Cosas de EnemyInmovil
	static public var enemyBalaSpeed:Int = 60;
	static public var timer:Float = 0;
	// Cosas de EnemyPerseguidor
	static public var enemySpeedXY = 50; // Se va a usar como módulo
}