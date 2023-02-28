extends Area2D


func walkedIn(body:Node):
	if body.name == "Player":
		body.sound = 1 
		body.updateAnimation()

func walkedOut(body:Node):
	if body.name == "Player":
		body.sound = 0
		body.updateAnimation()

