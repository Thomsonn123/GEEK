extends Node2D

var prefix = "Potions/"
onready var collectButton = get_node("Button")
onready var vinegarButton = get_node(prefix + "1potion")
onready var melisaButton = get_node(prefix + "2potion")
onready var healthButton = get_node(prefix + "3potion")

func _ready():
	collectButton.disabled = true

func button_pressed(name):
	if collectButton.disabled == true:
		if name == "vinegar":
			melisaButton.disabled = true
			healthButton.disabled = true
		elif name == "melisa":
			vinegarButton.disabled = true
			healthButton.disabled = true
		elif name == "health":
			vinegarButton.disabled = true
			melisaButton.disabled = true
		collectButton.disabled = false
	else:
		reset()
		


func reset():
	collectButton.disabled = true
	vinegarButton.disabled = false
	melisaButton.disabled = false
	healthButton.disabled = false
