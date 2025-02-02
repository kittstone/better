package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.input.gamepad.FlxGamepad;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class GameOverState extends FlxTransitionableState {
	var bfX, bfY:Float = 0;
	public function new(x:Float, y:Float) {
		super();
		bfX = x;
		bfY = y;
	}

	override function create() {
		var bf:Boyfriend = new Boyfriend(bfX, bfY);
		add(bf);
		bf.playAnim('firstDeath');
		FlxG.camera.follow(bf, LOCKON, 0.001);
		FlxG.sound.music.fadeOut(2, FlxG.sound.music.volume * 0.6);
		super.create();
	}

	private var fading:Bool = false;
	override function update(elapsed:Float) {
		var pressed:Bool = FlxG.keys.justPressed.ANY;
		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;
		pressed = false;
		if (gamepad != null && gamepad.justPressed.ANY) pressed = true;
		if (pressed && !fading) {
			fading = true;
			FlxG.sound.music.fadeOut(0.5, 0, function(twn:FlxTween) {
				FlxG.sound.music.stop();
				LoadingState.loadAndSwitchState(new PlayState());
			});
		}
		super.update(elapsed);
	}
}