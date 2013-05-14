package 
{
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	//Import the library for the pixel collision
	import com.coreyoneil.collision.CollisionList;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	
	public class Player extends MovieClip
	{
		public var vx:Number = 0;
		public var vy:Number = 0;
		
		public static var SpeedX:Number = 0.8;
		public static var SpeedY:Number = 0.8;
		public static var GRAVITY:Number = 0.75;

		public var ax:Number = 0;
		public var speed:Number = 0;
		public var friction:Number = 0.97;
		
		public var FRICTION_SPEED:Number = 0.92;
		public const ROTATION_SPEED:Number = 1.8;

		//set the mass of the object
		public const IMMOVABLE:Number = 10000;
		public const MASS:Number = IMMOVABLE * 2;

		//Movieclips of the level
		public static var level:MovieClip = new MovieClip();
		public static var garage:MovieClip = new MovieClip();
		public static var level_Visible:MovieClip = new MovieClip();
		public static var background1:MovieClip = new MovieClip();
		public static var background2:MovieClip = new MovieClip();
		public static var background3:MovieClip = new MovieClip();
		
		//Movieclips for the kart
		// It is just a emply container for the MovieClip 'kart'
		public static var container:MovieClip = new MovieClip();
		public static var kart:MovieClip = new MovieClip();
		
		public var timer:Timer = new Timer(15000);

		//Create our collision list, which is going to have player and the level(collision object)
		public var collisionList:CollisionList;
		public var carStop:Boolean = false;

		public function Player()
		{
			//Add level and this(player) to the collision list
			collisionList = new CollisionList(level);
			collisionList.addItem(this);
			kart.GracePush.alpha = 0;
			kart.Body.gotoAndStop(2);
			
			//Start all the events
			addEventListener(Event.ENTER_FRAME, updateStage);
			timer.addEventListener(TimerEvent.TIMER, timerEvent);
			timer.start();
			
		}

		public function timerEvent(e:TimerEvent)
		{
			carStop = true;
		}
		
		public function FinishTutLevel()
		{
			friction = 0.97;
			speed = 0.03;
			kart.Body.gotoAndStop(1);
			kart.GracePush.alpha = 1;
			kart.GracePush.gotoAndPlay(1);
			carStop = false;
			timer.stop();
		}
		public function keyboardDown(e:KeyboardEvent)
		{
			switch (e.keyCode)
			{
				case Keyboard.LEFT :
					speed = -0.05;
					break;

				case Keyboard.RIGHT :
					speed = 0.05;
					break;

				case Keyboard.SPACE :
					friction = 0.90;
					break;
			}
		}

		public function keyboardUp(e:KeyboardEvent)
		{
			switch (e.keyCode)
			{
				case Keyboard.LEFT :
					speed = 0;
					break;

				case Keyboard.RIGHT :
					speed = 0;
					break;

				case Keyboard.SPACE :
					friction = 0.97;
					break;
			}
		}
		
		public function moveKart()
		{
			
			
			friction -= 0.00023;
			
			
			if(carStop == false)
			{
			var speed:Number = this.vx;
			
			container.rotation = this.rotation;
			container.x = this.x;
			container.y = this.y;
			
				kart.wheel1.rotation += speed;
				kart.wheel2.rotation += speed;
			}
			//move kart backwards if right arrow button is pressed
			if(speed > 1 && kart.x > 0)
			{
				kart.x-=2;
			}
			
			//move kart forwards if left arrow button is pressed
			else if(speed < -1  &&(kart.x < 30))
			{
				kart.x+=0.40;
			}
		}
		
		public function updateStage(e:Event)
		{
			var collisions:Array = collisionList.checkCollisions();
			kart.Grace.alpha = 0;
			moveKart();
			
			if (this.hitTestObject(level_Visible.endLevel))
			{
				kart.alpha = 0;
				carStop = true;
			}
			
			if (collisions.length > 0)
			{
				//kart.Grace.gotoAndStop(1)
				var collision:Object = collisions[0];
				var angle:Number = collision.angle;
				var overlap:int = collision.overlapping.length;

				//Cordinate Rotation Formula
				var sin:Number = Math.sin(angle);
				var cos:Number = Math.cos(angle);

				var vx0:Number = vx * cos + vy * sin;
				var vy0:Number = vy * cos - vx * sin;
				
				angle = (angle * 180 / Math.PI) - 90;

				if(angle > this.rotation)
				{
					this.rotation += ROTATION_SPEED;
				}else if(angle <this.rotation)
				{
					this.rotation -= ROTATION_SPEED;
				}
				
				vx0 = ((MASS - IMMOVABLE) * vx0) / (MASS + IMMOVABLE);

				vx = vx0 * cos - vy0 * sin;
				vy = vy0 * cos + vx0 * sin;

				vx -=  cos * overlap / 10;
				vy -=  sin * overlap / 25;
			
				ax +=  speed;
				vx +=  ax;
				vy *=  friction;
				vx *=  friction;
			}
			else kart.Grace.gotoAndStop(2)
			
			//Apply gravity and friction to vy and ax
			ax *=  FRICTION_SPEED;
			vy +=  GRAVITY;
			
			//Reduce the speed
			var vxPlayer:Number = vx * SpeedX;
			var vyPlayer:Number = vy * SpeedY;
			
			if(carStop == true)
			{
				vxPlayer = 0; 
			}
			
			var levelSize:int = (-level.x) * 100 / (level.width - stage.stageWidth);
			
			if((this.x < ((stage.stageWidth / 2) - 10) && vx < 0 && level.x < 0 )||
			   (this.x > ((stage.stageWidth / 2) + 10) && vx > 0 && levelSize < 99 ))
			{
				level.x -= vxPlayer;
				garage.x -= vxPlayer;
				level_Visible.x -= vxPlayer;
				background1.x -= vxPlayer / 2;
				background2.x -= vxPlayer / 4;
				background3.x -= vxPlayer / 8;
			}
			else
			{
				if(this.x > 10)
				{
					this.x +=  vxPlayer;
				}else
				{
					this.x = 12;
				}
			}
			
			if((this.y > ((stage.stageHeight / 2) + 100) && vy > 1 && (level.height + level.y) > (stage.stageHeight + 10))||(this.y < ((stage.stageHeight / 2)) && vy < -1))
			{
				level.y -= vyPlayer;
				garage.y -= vyPlayer;
				level_Visible.y -= vyPlayer;
				background1.y -= vyPlayer / 2;
				background2.y -= vyPlayer / 4;
				background3.y -= vyPlayer / 8;
			}
			
			else
			{
				this.y +=  vyPlayer;
			}
			
			/*
			
			trace(level.x , stage.stageWidth - level.width)
			
			
			if(background1.x > stage.stageWidth - background1.width)
			{
				background1.x = stage.stageWidth - background1.width;
				trace("asdsa")
			}
			
			if(level.x > stage.stageWidth - level.width)
			{
				trace("asdsasdf")
				level.x = stage.stageWidth - level.width;
				level_Visible.x = stage.stageWidth - level_Visible.width;
			}
			
			*/
		}
	}
}