package entities;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.group.FlxGroup.FlxTypedGroup;

class Boss extends FlxSprite 
{
	
	public var life:Int;
	private var speed:Float;
	private var framesEntreBalas:Int;
	private var balasArray:FlxTypedGroup<BalaEne>;

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset, ?bossBalasArray:FlxTypedGroup<BalaEne>) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.Boss__png, false, 64, 120);
		life = 100;
		framesEntreBalas = Reg.bossFramesEntreBalas;
		balasArray = bossBalasArray;
		speed = Reg.bossNormalSpeed;
		velocity.set(0, speed);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		framesEntreBalas++;
		movimiento();
		shot();
	}
	
	private function shot(): Void
	{
		if (life > 50)
		{
			if (framesEntreBalas >= 100)
			{
				var nuevaBala = new BalaEne (x + width, y + height / 2);
				balasArray.add(nuevaBala);
				framesEntreBalas = 0;
			}
		}
		else 
		{
			speed = Reg.bossBerserkSpeed;
			if (framesEntreBalas >= 50)
			{
				var nuevaBala = new BalaEne (x + width, y + height / 2);
				balasArray.add(nuevaBala);
				framesEntreBalas = 0;
			}
		}
	}
	
	private function movimiento():Void
	{
		if (y > FlxG.height - 24 - height)
			velocity.y -= speed;
		if (y <= 0 )
			velocity.y += speed;
	}
	
	public function getDamage()
	{
		if (life == 0)
		{
			destroy();
		}
		else life--;
	}
}