extends KinematicBody2D

export(NodePath) var Player

func body_entered(body:Node):
	print(body)
	if body.name == "Player":
		body.actionName = "Herbalist"
		body.action = "Herbalist"

func body_exited(body:Node):
	if body.name == "Player":
		body.actionName = null
		body.action = null
