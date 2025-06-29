class_name Ball
extends CharacterBody2D

const MOVE_SPEED: float = 1000.0

var startPosition: Vector2
var angle: float
var maxAngle: float = deg_to_rad(45) # Maximum bounce angle

func _ready():
	var direction: Vector2 = Vector2(1, 0).rotated(0)
	self.velocity = direction * MOVE_SPEED

func _physics_process(delta: float) -> void:
	if get_tree().current_scene.gameStarted:
		var collision: KinematicCollision2D = move_and_collide(self.velocity * delta)

		if collision:
			if collision.get_collider() is PlayerPaddle:
				var collisionDistance: float = self.global_position.y - collision.get_collider().global_position.y
				var paddleMidDistance: float = collision.get_collider().get_node("CollisionShape").shape.size.x / 2

				var directionX = -1 * sign(self.velocity.x) # flips the direction of the ball horizontally

				var offset = clamp(collisionDistance / paddleMidDistance, -1.0, 1.0)
				angle = offset * maxAngle

				self.velocity = Vector2(directionX * cos(angle), sin(angle)) * MOVE_SPEED
			else:
				self.velocity = self.velocity.bounce(collision.get_normal())

# Resets the position of the ball to the center of the screen
func resetPosition() -> void:
	self.position = Vector2(0, 0)
	var direction: Vector2 = Vector2(1, 0).rotated(0)
	self.velocity = direction * MOVE_SPEED



	
