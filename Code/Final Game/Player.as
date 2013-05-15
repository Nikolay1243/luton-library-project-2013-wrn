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
		
		public static var SpeedX:Number = 0.4;
		public static var SpeedY:Number = 0.4;
		public static var GRAVITY:Number = 0.75;

		public var ax:Number = 0;
		public var speed:Number = 0;
		public var friction:Number = 0.97;
		
		public const FRICTION_SPEED:Number = 0.92;
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
		public static var whichLevel:int = 0;
		//Create our collision list, which is going to have player and the level(collision object)
		public var collisionList:CollisionList;
		
		
		public function Player()
		{
			//Add level and this(player) to the collision list
			collisionList = new CollisionList(level);
			collisionList.addItem(this);
			
			
			//Start all the events
			addEventListener(Event.ENTER_FRAME, updateStage);
		}
		
		//This function is called when a keyboard button is pressed
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
		//this function is called when the keyboard button is up
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
		
		//this function moves the kart along the level
		public function moveKart()
		{
			var speed:Number = this.vx;
			
			container.rotation = this.rotation;
			container.x = this.x;
			container.y = this.y;
			
			kart.wheel1.rotation += speed;
			kart.wheel2.rotation += speed;
			
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
		
		//this function updates the level by looking at the collisions
		public function updateStage(e:Event)
		{
			var collisions:Array = collisionList.checkCollisions();
			
			moveKart();
			
			if (collisions.length > 0)
			{
				kart.Grace.gotoAndStop(1)
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
			
			
			if(whichLevel == 4)
			{
				//background1.x = level.x;
			}
			
			
		}
	}
}