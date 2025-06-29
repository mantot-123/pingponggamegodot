class_name GameManager

extends Node2D

var gameStarted: bool = false

signal playerScored

func _ready() -> void:
    playerScored.connect(_onPlayerScored)
    get_node("ScoreLabelLeft").text = "Player 1 score: " + str(get_node("PlayerPaddleLeft").score)
    get_node("ScoreLabelRight").text = "Player 2 score: " + str(get_node("PlayerPaddleRight").score)

func _process(delta: float) -> void:
    if Input.is_action_pressed("start_game") and not gameStarted:
        gameStarted = true
        get_node("StartGameTipLabel").visible = false

func _onPlayerScored(player: PlayerPaddle) -> void:
    if player == get_node("PlayerPaddleLeft"):
        get_node("ScoreLabelLeft").text = "Player 1 score: " + str(player.score)
    elif player == get_node("PlayerPaddleRight"):
        get_node("ScoreLabelRight").text = "Player 2 score: " + str(player.score)
    gameRestart()

func gameRestart() -> void:
    gameStarted = false
    get_node("PlayerPaddleLeft").position = Vector2(-570.0, 0.0)
    get_node("PlayerPaddleRight").position = Vector2(570.0, 0.0)
    get_node("Ball").resetPosition()