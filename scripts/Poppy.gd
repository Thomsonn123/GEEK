extends Area2D

var collected = false
export(NodePath) var Player = null

func collect():
	if collected == false:
		collected = true
		$Timer.start()
		get_node(Player).add("Poppy")
		self.visible = false

func timerFinish():
	collected = false
	self.visible = true

func _on_Poppy_body_entered(body:Node):
	if body.name == "Player":
		body.entity = self.get_path()


func _on_Poppy_body_exited(body:Node):
	if body.name == "Player":
		body.entity = null
