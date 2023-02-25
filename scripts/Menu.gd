extends Node2D
export(NodePath) var Player

func _ready():
	Player = get_node(Player)
func close():
	get_tree().quit()

func soundsValueChanged(value):
	Player.soundValue(value)
