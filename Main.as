package {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.text.*;
	import flash.geom.Point;
	import flash.ui.GameInput;

	public class Main extends MovieClip {

		public var player: Player;
		public var enemy; // collision player test
		public var enemy2; // beweging test
		public var hits = 0;
		public var m;
		public var gameover;

		public var mark: int;
		public var started: Boolean = false;

		public var markLives: int;
		public var startedLives: Boolean = false;

		public var Text: TextField = new TextField();
		public var Hitt: TextField = new TextField();

		public var Score: MovieClip;
		public var Hit: MovieClip;
		public var coll = 0;

		public function Main() {
			gameover = new Game(); // gameover scherm
			// (x location, y location, topspeed, velocity_X, velocity_Y)
			player = new Player(500, 500, 10 /*, 0, 0*/ );
			this.addChild(player);

			// (x location, y location, topspeed, velocity_X, velocity_Y)
			// test enemy voor collision met player
			enemy = new Enemy(700, 100, 0, 2.5, 2.5);
			this.addChild(enemy);

			// test enemy voor collision mijn die de player kan plaatsen
			enemy2 = new Enemy(100, 100, 10, 2.5, 2.5);
			this.addChild(enemy2);

			m = new Mine();

			//timer ----------------//
			Score = new scure;
			Score.x = 850;
			Score.y = 0;
			this.addChild(Score)
			Score.addChild(Text);

			Hit = new Lives;
			Hit.x = 1060;
			Hit.y = 0;
			this.addChild(Hit);
			Hit.addChild(Hitt);

			started = true;

			Text.defaultTextFormat = new TextFormat("Arial", 50, 0x1D0D24);
			//font , size , color
			Hitt.defaultTextFormat = new TextFormat("Arial", 50, 0xFFFFFF);

			addEventListener(Event.ENTER_FRAME, Update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}

		public function get elapsed(): int {
			return started ? getTimer() - mark : 0;
			return started ? getTimer() - markLives : 0;
		}

		public function Update(e: Event) {
			//timer------
			if (coll == 0) { // stopt de game zijn timer als je een asteried een hebt geraakt die vast zit op zijn plaats
				//trace(mark, "Seconds survived");
				mark = getTimer() * 0.001;
				Text.text = mark.toString();
				markLives = 1;
				Hitt.text = markLives.toString();
				var mouse = new Vector2(root.mouseX, root.mouseY);
			}


			// als asteroids elkaar raken verdwijnt er een en zorgt die voor error 2025
			if (enemy != null) {
				if (player.hitTestObject(enemy) == true) {
					removeChild(enemy);
					enemy = null;
					coll++; // zorgt er voor dat de timer stopt op hit
					hits++;
					trace(hits, "hit(s) door collisie object1");
				}
			}

			// kijkt of de mijn een enemy aan raakt en verwijdert dan de enemy en de mijn van het scherm.
			if (enemy2 != null) {
				if (m.hitTestObject(enemy2) == true) {
					removeChild(enemy2); // wordt geactiveerd op botsing met enemy 1
					enemy2 = null;
					//coll++ // zorgt er voor dat de timer stopt op hit
					//hits++;
					trace(hits, "hit(s) door opblazen mijn");
					removeChild(m); // veroorzaakt de error als het niet op stage is 2025
				}

				if (player.hitTestObject(enemy2) == true) {
					removeChild(enemy2);
					enemy2 = null;
					coll++; // zorgt er voor dat de timer stopt op hit
					hits++;
					trace(hits, "hit(s) door collisie object2");
				}
			}

			// als je bent geraakt komt er game over te staan
			if (hits == 1) {
				gameover.x = 755.50;
				gameover.y = 478.55;
				this.addChild(gameover);
				player.alpha = 0; // maakt de speler doorzichtig
			}

		}

		// Als je op een toest klick op je keyboard plaats je een mijn die een asteroide kan vernielen op hit.
		function keyDown(pEvent) {
			this.addChild(m);
			trace("mine placed");
			m.x = player.x;
			m.y = player.y;
		}

	}

}