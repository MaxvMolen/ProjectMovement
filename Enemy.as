package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.DisplayObject;

	public class Enemy extends MovieClip {

		var position;
		var velocity;
		var acceleration;
		var topspeed;

		var xxx;
		var yyy;
		var s;

		var vx;
		var vy;
		
		var angle;

		public function Enemy(xxx, yyy, s, vx, vy) {

			this.position = new Vector2(xxx, yyy);
			this.velocity = new Vector2(vx, vy);
			this.acceleration = new Vector2(0.01, 0.02);

			this.topspeed = s;

			addEventListener(Event.ENTER_FRAME, Update);
		}

		public function Update(e: Event) {
			// de speed van hoe snel een object draait
			var speed = 0.75;
			this.x = position.x;
			this.y = position.y;
			// draait het object steets rond
			this.rotation += speed;

			this.velocity.add(this.acceleration);
			this.velocity.limit(this.topspeed);
			this.position.add(this.velocity);

			if (position.x > 1950) {
				position.x = -30;
			}

			if (position.y > 1130) {
				position.y = -30;
			}

			if (position.x < -30) {
				position.x = 1920;
			}

			if (position.y < -30) {
				position.y = 1080;
			}

		}

	}

}