import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with HasCollisionDetection {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(SpriteComponent()
      ..sprite = await loadSprite('background.jpeg')
      ..size = size);
    add(Bowser(await loadSprite('bowser.png')));
    add(Yoshi(await loadSprite('yoshi.png')));
  }
}

class Bowser extends SpriteComponent with CollisionCallbacks {
  bool _collision = false;
  Bowser(Sprite sprite) {
    this.sprite = sprite;
    size = Vector2(75.0, 75.0);
    anchor = Anchor.center;
    position = Vector2(100.0, 200.0);
    debugMode = true;
    add(RectangleHitbox());
  }
  @override
  void update(double dt) {
    super.update(dt);
    x += 1;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    _collision = true;
    if (other is Yoshi) {
      print('you lose try again');
    }
  }
}

class Yoshi extends SpriteComponent with CollisionCallbacks {
  Yoshi(Sprite sprite) {
    this.sprite = sprite;
    size = Vector2(75.0, 75.0);
    anchor = Anchor.center;
    position = Vector2(600.0, 200.0);
    debugMode = true;
    add(RectangleHitbox());
  }
}
