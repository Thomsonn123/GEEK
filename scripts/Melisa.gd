extends Area2D

var collected = false
export(NodePath) var Player = null
var time = 20

func _ready():
	$Timer.wait_time = time


func collect():
	if collected == false:
		collected = true
		$Timer.start()
		get_node(Player).add("Melisa")
		self.visible = false

func timerFinish():
	collected = false
	self.visible = true

func _on_Melisa_body_entered(body:Node):
	if body.name == "Player":
		body.entity = self.get_path()

func _on_Melisa_body_exited(body:Node):
	if body.name == "Player":
		body.entity = null
