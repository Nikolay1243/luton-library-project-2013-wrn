package  {
	import flash.display.MovieClip;
	import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class GameSound extends MovieClip{
		
		public static var player:Player;
		
		public var engineSoundPlaying:Boolean = false;
		public var forwardSoundPlaying:Boolean = false;
		public var backwardSoundPlaying:Boolean = false;
		
		
		public var engineSound:Sound = new ClickSound();
		public var forwardSound:Sound = new ClickSound1();
		public var backwardSound:Sound = new Whoosh1();
		
		public var channel:SoundChannel;
		public var engineChannel:SoundChannel;
		

		public function GameSound() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, playLevelSounds)
		}
		
		public function playLevelSounds(e:Event)
		{
			//Engine sound
			if(!engineSoundPlaying)
            {
                engineChannel = engineSound.play();
                engineChannel.addEventListener(Event.SOUND_COMPLETE, handleEngineSound);
                engineSoundPlaying = true;
            }
			
			//Backwards sound
			if(player.speed == -0.05)
			{
				if(!backwardSoundPlaying)
            	{
                	channel = backwardSound.play();
                	channel.addEventListener(Event.SOUND_COMPLETE,handleBackwardSound);
                	backwardSoundPlaying = true;
            	}
			}
			//Forwards sound
			if (player.speed == 0.05)
			{
				if(!forwardSoundPlaying)
            	{
                	channel = forwardSound.play();
                	channel.addEventListener(Event.SOUND_COMPLETE,handleForwardSound);
                	forwardSoundPlaying = true;
            	}
			}
			
			//if the player press space (break) -> it reduces the volume of the engine
			var volumeSound:SoundTransform = engineChannel.soundTransform;
			if(player.friction == 0.90)
			{
				volumeSound.volume = 0.5;
				engineChannel.soundTransform = volumeSound;
			}else
			{
				volumeSound.volume = 1;
				engineChannel.soundTransform = volumeSound;
			}

		}
		
		public function handleEngineSound(e:Event)
		{
			engineSoundPlaying = false;
		}
		
		public function handleForwardSound(e:Event)
		{
			forwardSoundPlaying = false;
		}
		
		public function handleBackwardSound(e:Event)
		{
			backwardSoundPlaying = false;
		}
		
	}
	
}
