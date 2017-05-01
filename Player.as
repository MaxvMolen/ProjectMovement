package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.DisplayObject;

	public class Player extends MovieClip {

		var position;
		var velocity;
		var acceleration;
		var topspeed;
		var dir = new Vector2();

		//steer
		var r;
		var maxforce;
		var maxspeed;

		var desired;
		var steer;

		// player x en y positie en top snelheid
		var xxx;
		var yyy;
		var s;
		// velocity x een y posities
		var vx = 0;
		var vy = 0;

		var angle;
		// position_x, position_y, topspeed, velocity_x, velocity_y
		public function Player(xxx, yyy, s /*, vx, vy*/ ) {

			this.position = new Vector2(xxx, yyy);
			this.velocity = new Vector2(vx, vy);
			this.acceleration = new Vector2(0, 0);

			r = 3, 0;
			maxspeed = 10;
			maxforce = 0, 1;

			this.topspeed = s;

			addEventListener(Event.ENTER_FRAME, Update);
		}

		public function Update(e: Event) {
			var mouse = new Vector2(root.mouseX, root.mouseY);
			dir.create(position, mouse);
			dir.normalize();
			dir.multS(0.5);

			angle = Math.atan2(root.mouseY - this.y, root.mouseX - this.x);
			angle *= 180 / Math.PI;
			this.rotation = angle
			acceleration = dir;

			this.x = position.x;
			this.y = position.y;

			this.velocity.add(this.acceleration);
			this.velocity.limit(this.maxspeed);
			this.position.add(this.velocity);
			this.acceleration.multS(0);

			if (position.x > 1920) {
				position.x = 1;
			}

			if (position.y > 1080) {
				position.y = 1;
			}

			if (position.x < 1) {
				position.x = 1920;
			}

			if (position.y < 1) {
				position.y = 1080;
			}

		}

	}

}