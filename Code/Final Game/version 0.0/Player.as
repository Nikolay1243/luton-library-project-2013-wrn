package 
{
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.ui.Keyboard;
	//Import the library for the pixel collision
	import com.coreyoneil.collision.CollisionList;
	
	public class Player extends MovieClip
	{
		public var vx:Number = 0;
		public var vy:Number = 0;

		public var ax:Number = 0;
		public var speed:Number = 0;
		public var friction:Number = 0.97;
		
		public const GRAVITY:Number = 0.75;
		public const FRICTION_SPEED:Number = 0.92;
		public const ROTATION_SPEED:Number = 1.4;

		//set the mass of the object
		public const IMMOVABLE:Number = 10000;
		public const MASS:Number = IMMOVABLE * 2;

		//Movieclips of the level
		public static var level:MovieClip = new MovieClip();
		public static var background1:MovieClip = new MovieClip();
		public static var background2:MovieClip = new MovieClip();
		public static var background3:MovieClip = new MovieClip();

		//Create our collision list, which is going to have player and the level(collision object)
		public var collisionList:CollisionList;

		public function Player()
		{
			// constructor code
			
			//Add level and this(player) to the collision list
			collisionList = new CollisionList(level);
			collisionList.addItem(this);
			
			//Start all the event
			addEventListener(Event.ENTER_FRAME, updateStage);
		}

		public function keyboardDown(e:KeyboardEvent)
		{
			switch (e.keyCode)
			{
				case Keyboard.LEFT :
					speed = -.05;
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
		
		public function mouseDownEvent(e:MouseEvent)
		{
			vx += 5;
		}
		
		public function updateStage(e:Event)
		{
			var collisions:Array = collisionList.checkCollisions();

			if (collisions.length > 0)
			{
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
				}else if(angle < this.rotation)
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

			//Apply gravity and friction to vy and ax
			ax *=  FRICTION_SPEED;
			vy +=  GRAVITY;
			this.y +=  vy;
			
			var levelSize:int = (-level.x+stage.stageWidth) * 100 / level.width;
			
			if(this.x < 395 && vx < 0 && level.x < 0)
			{
				level.x -= vx;
				background1.x -= vx / 2;
				background2.x -= vx / 4;
				background3.x -= vx / 8;
			}
			else if(this.x > 405 && vx > 0 && levelSize < 99)
			{
				level.x -= vx;
				background1.x -= vx / 2;
				background2.x -= vx / 4;
				background3.x -= vx / 8;
			}
			else
			{
				this.x +=  vx;
			}
		}
		
	}

}