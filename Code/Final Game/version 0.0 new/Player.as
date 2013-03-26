﻿package 
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
		public static var level_Visible:MovieClip = new MovieClip();
		public static var background1:MovieClip = new MovieClip();
		public static var background2:MovieClip = new MovieClip();
		public static var background3:MovieClip = new MovieClip();
		
		//Movieclips for the kart
		// It is just a emply container for the MovieClip 'kart'
		public static var container:MovieClip = new MovieClip();
		public static var kart:MovieClip = new MovieClip();

		//Create our collision list, which is going to have player and the level(collision object)
		public var collisionList:CollisionList;

		public function Player()
		{
			// constructor code
			
			//Add level and this(player) to the collision list
			collisionList = new CollisionList(level);
			collisionList.addItem(this);
			
			//Start all the event
			addEventListener(Event.ENTER_FRAME, panorama);
		}
		
		public function panorama(e:Event)
		{
			var levelSize:int = (-level.x) * 100 / level.width;
			
			if(levelSize == 0)
			{
				addEventListener(Event.ENTER_FRAME, updateStage);
				this.removeEventListener(Event.ENTER_FRAME, panorama);
			}
			
			level.x += 10;
			level_Visible.x += 10;
			background1.x += 10 / 2;
			background2.x += 10 / 4;
			background3.x += 10 / 8;
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
		
		public function moveKart()
		{
			var speed:Number = this.vx;
			
			container.rotation = this.rotation;
			container.x = this.x;
			container.y = this.y;
			
			kart.wheel1.rotation += speed;
			kart.wheel2.rotation += speed;
			
			if(speed > 1)
			{
				if(kart.x > 0)
				{
					kart.x--;
				}
			}
			else if(speed < -1)
			{
				if(kart.x < 50)
				{
					kart.x++;
				}
			}
		}
		
		public function mouseDownEvent(e:MouseEvent)
		{
			vx += 5;
		}
		
		public function updateStage(e:Event)
		{
			
			moveKart();
			
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
				level_Visible.x -= vx;
				background1.x -= vx / 2;
				background2.x -= vx / 4;
				background3.x -= vx / 8;
			}
			else if(this.x > 405 && vx > 0 && levelSize < 99)
			{
				level.x -= vx;
				level_Visible.x -= vx;
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