extends Area2D

export(NodePath) var Robot = null
var robPath = null
func _on_Monitor_body_entered(body:Node):
	if body.name == "Player":
		if robPath == null:
			robPath = get_node_or_null(Robot).get_path()
		body.walkedInMonitor(self.get_path(), self.name, robPath)


func _on_Monitor_body_exited(body:Node):
	if body.name == "Player":
		body.bodyOut()
