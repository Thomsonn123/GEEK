extends Area2D

export(NodePath) var Robot = null

func _on_Monitor_body_entered(body:Node):
	if body.name == "Player":
		var robPath = get_node(Robot).get_path()
		body.walkedInMonitor(self.get_path(), self.name, robPath)


func _on_Monitor_body_exited(body:Node):
	if body.name == "Player":
		body.bodyOut()
