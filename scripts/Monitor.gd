extends Area2D

export(NodePath) var Robot = null

func _on_Monitor_body_entered(body:Node):
	if body.name == "Player":
		body.walkedInMonitor(self.get_path(), self.name, Robot)


func _on_Monitor_body_exited(body:Node):
	if body.name == "Player":
		body.bodyOut()
