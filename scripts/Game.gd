extends Node2D

var PlayerStartPosition = Vector2(-3008, 1152)

func _ready():
	startGame()

func startGame():
	$Player.position = PlayerStartPosition

func restartGame():
	$Player.changeStatus("Zaczynasz od nowa")
	startGame()
func _physics_process(_delta):
	#print(Engine.get_frames_per_second())
	pass
	