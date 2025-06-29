class_name ScoreArea

extends Area2D

@export var player: PlayerPaddle

func _ready() -> void:
	body_entered.connect(_onBallEntered)

func _onBallEntered(body: Node2D) -> void:
	if body is Ball:
		player.playerScored.emit()
