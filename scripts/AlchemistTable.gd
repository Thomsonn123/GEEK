extends StaticBody2D

func playerEntered(body:Node):
	if body.name == "Player":
		body.actionName = "Alchemist"
		body.action = "Alchemist"

func playerExited(body:Node):
	if body.name == "Player":
		body.actionName = null
		body.action = null
