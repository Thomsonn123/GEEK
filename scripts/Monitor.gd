extends Area2D



func _on_Monitor_body_entered(body:Node):
	if body.name == "Player":
		body.walkedInMonitor(self.get_path())

func sendAction():
	pass
