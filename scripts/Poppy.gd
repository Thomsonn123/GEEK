extends Area2D

var collected = false
export(NodePath) var Player = null
var time = 40

func _ready():
	$Timer.wait_time = time


func collect():
	if collected == false:
		collected = true
		$Timer.start()
		get_node(Player).add("Poppy")
		self.visible = false
		get_node(Player).entity = null

func timerFinish():
	collected = false
	self.visible = true

func _on_Poppy_body_entered(body:Node):
	if body.name == "Player":
		if body.autocollect == true:
			collect()
		else:
			body.entity = self.get_path()


func _on_Poppy_body_exited(body:Node):
	if body.name == "Player":
		body.entity = null
