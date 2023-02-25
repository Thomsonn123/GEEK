extends StaticBody2D

var bubbles = preload("res://sounds/bubbles.mp3")
var working = preload("res://sounds/boiling.mp3")

func sounds(value):
	if value == "working":
		$AudioPlayer.stream = working
		$AudioPlayer.play()
	elif value == "finish":
		$AudioPlayer.stream = bubbles
		$AudioPlayer.play()
	elif value == "end":
		$AudioPlayer.stop()

func playerEntered(body:Node):
	if body.name == "Player":
		body.actionName = "Alchemist"
		body.action = "Alchemist"

func playerExited(body:Node):
	if body.name == "Player":
		body.actionName = null
		body.action = null
