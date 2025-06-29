class_name PlayerPaddle

extends CharacterBody2D

enum ControlledBy {AI, PLAYER1, PLAYER2}

@export var controlledBy: ControlledBy

var score: int
var canMove: bool = false

signal playerScored

const MOVE_SPEED: float = 800.0

func _ready() -> void:
	playerScored.connect(_onPlayerScored)

func _process(delta: float) -> void:
	if self.get_tree().current_scene.gameStarted:
		canMove = true
	else:
		canMove = false

	if canMove:
		var moveDir: float = 0.0
		if controlledBy == ControlledBy.PLAYER1:
			moveDir = Input.get_axis("move_player1_paddle_up", "move_player1_paddle_down")
		elif controlledBy == ControlledBy.PLAYER2:
			moveDir = Input.get_axis("move_player2_paddle_up", "move_player2_paddle_down")

		if moveDir != 0:
			self.velocity.y = moveDir * MOVE_SPEED
		else:
			self.velocity.y = 0.0

	move_and_slide()

func _onPlayerScored() -> void:
	score += 1	
	self.get_tree().current_scene.playerScored.emit(self)