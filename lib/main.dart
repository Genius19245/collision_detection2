import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with HasCollisionDetection, HasTappables {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(SpriteComponent()
      ..sprite = await loadSprite('77.jpg')
      ..size = size);
    add(Left(await loadSprite('bowser.png')));
    add(Right(await loadSprite('bowser.png')));
    add(Cars(await loadSprite('sports.png')));
    add(Car(await loadSprite('sports.png')));
    add(Player(await loadSprite('yoshis.png')));
  }
}

class Car extends SpriteComponent with CollisionCallbacks {
  bool _collision = false;
  Car(Sprite sprite) {
    flipHorizontally();
    this.sprite = sprite;
    size = Vector2(150.0, 100.0);
    anchor = Anchor.center;
    position = Vector2(1200.0, 550.0);
    add(RectangleHitbox());
  }
  @override
  void update(double dt) {
    super.update(dt);
    x -= 4.5;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    _collision = true;
    if (other is Left) {
      position = Vector2(1200.0, 550.0);
    }
  }
}

class Cars extends SpriteComponent with CollisionCallbacks {
  bool _collision = false;
  Cars(Sprite sprite) {
    this.sprite = sprite;
    size = Vector2(150.0, 100.0);
    anchor = Anchor.center;
    position = Vector2(100.0, 525.0);
    debugMode = true;
    add(RectangleHitbox());
  }
  @override
  void update(double dt) {
    super.update(dt);
    x += 4.5;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    _collision = true;
    if (other is Right) {
      position = Vector2(-300.0, 525.0);
    }
  }
}

class Left extends SpriteComponent with CollisionCallbacks {
  Left(Sprite sprite) {
    this.sprite = sprite;
    size = Vector2(75.0, 75.0);
    anchor = Anchor.center;
    position = Vector2(-300.0, 500.0);
    debugMode = true;
    add(RectangleHitbox());
  }
}

class Right extends SpriteComponent with CollisionCallbacks {
  Right(Sprite sprite) {
    this.sprite = sprite;
    size = Vector2(75.0, 75.0);
    anchor = Anchor.center;
    position = Vector2(1400.0, 500.0);
    debugMode = true;
    add(RectangleHitbox());
  }
}

class Player extends SpriteComponent with CollisionCallbacks, Tappable {
  Player(Sprite sprite) {
    this.sprite = sprite;
    size = Vector2(65.0, 65.0);
    anchor = Anchor.center;
    position = Vector2(600.0, 650.0);
    add(RectangleHitbox());
  }

  @override
  bool onTapDown(TapDownInfo info) {
    y -= 50;
    x -= 50;
    return super.onTapDown(info);
  }

  @override
  void Update(dt) {
    super.update(dt);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Cars) {
      print('touching cars');
    }
  }
}
