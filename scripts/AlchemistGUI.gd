extends Node2D

export(NodePath) var Player

var prefix = "Potions/"
onready var collectButton = get_node("Button")
onready var vinegarButton = get_node(prefix + "1potion")
onready var melisaButton = get_node(prefix + "2potion")
onready var healthButton = get_node(prefix + "3potion")
onready var waterButton = get_node(prefix + "4potion")
onready var spinBox = get_node("Box/SpinBox")
onready var box = get_node("Box")

var neededIngridents = [10,5,15,5]

var apple = 0
var dandelion = 0
var melisa = 0
var poppy = 0
var choosen = null
var valuee = 0

func _ready():
	reset()
	collectButton.disabled = true
	box.disabled = true
	box.visible = false
	$Start.disabled = true

func open():
	if choosen == null:
		reset()

func button_pressed(name):
	var multipler = 0
	if collectButton.disabled == true:
		if name == "vinegar":
			melisaButton.disabled = true
			healthButton.disabled = true
			waterButton.disabled = true
			multipler = apple / neededIngridents[0]
			spinBox.max_value = multipler
		elif name == "melisa":
			vinegarButton.disabled = true
			healthButton.disabled = true
			waterButton.disabled = true
			multipler = melisa / neededIngridents[1]
			print(multipler)
			spinBox.max_value = multipler
		elif name == "health":
			vinegarButton.disabled = true
			melisaButton.disabled = true
			waterButton.disabled = true
			multipler = dandelion / neededIngridents[2]
			spinBox.max_value = multipler
		elif name == "water":
			melisaButton.disabled = true
			vinegarButton.disabled = true
			healthButton.disabled = true
			multipler = poppy / neededIngridents[3]
			spinBox.max_value = multipler
		box.disabled = false
		box.visible = true
		choosen = name
		print("Button ", name)
		$Start.disabled = false
	else:
		reset()

func reset():
	melisa = get_node(Player).herbs[0]
	dandelion = get_node(Player).herbs[1]
	poppy = get_node(Player).herbs[2]
	apple = get_node(Player).herbs[3]
	box.disabled = true
	box.visible = false
	if neededIngridents[0] <= apple:
		vinegarButton.disabled = false
	else:
		vinegarButton.disabled = true
	if neededIngridents[1] <= melisa:
		melisaButton.disabled = false
	else:
		melisaButton.disabled = true
	if neededIngridents[2] <= dandelion:
		healthButton.disabled = false
	else:
		healthButton.disabled = true
	if neededIngridents[3] <= poppy:
		waterButton.disabled = false
	else:
		waterButton.disabled = true

func potionReady():
	get_node(Player).alchemistTableSounds("finish")
	$ProgressBar.value = 0
	collectButton.disabled = false
	box.visible = false

func GUIButtons(value):
	if value == "start":
		get_node(Player).alchemistTableSounds("working")
		var choosenHerbs = [0,0,0,0]
		$Timer.start()
		if choosen == "melisa":
			choosenHerbs[0] = int(neededIngridents[1] * $Box/SpinBox.value)
		elif choosen == "vinegar":
			choosenHerbs[3] = int(neededIngridents[0] * $Box/SpinBox.value)
		elif choosen == "health":
			choosenHerbs[1] = int(neededIngridents[2] * $Box/SpinBox.value)
		elif choosen == "water":
			choosenHerbs[2] = int(neededIngridents[3] * $Box/SpinBox.value)
		get_node(Player).herbs[0] -= choosenHerbs[0]
		get_node(Player).herbs[1] -= choosenHerbs[1]
		get_node(Player).herbs[2] -= choosenHerbs[2]
		get_node(Player).herbs[3] -= choosenHerbs[3]
		$Start.disabled = true
		valuee = $Box/SpinBox.value
		vinegarButton.disabled = true
		melisaButton.disabled = true
		healthButton.disabled = true
		waterButton.disabled = true

	if value == "collect":
		if choosen == "vinegar":
			get_node(Player).potions[0] += valuee
		elif choosen == "melisa":
			get_node(Player).potions[1] += valuee
		elif choosen == "health":
			print("działa")
			get_node(Player).potions[2] += valuee
		elif choosen == "water":
			get_node(Player).potions[3] += valuee
		choosen = null
		collectButton.disabled = true
		get_node(Player).alchemistTableSounds("end")
		reset()
	

func _on_Timer_timeout():
	$ProgressBar.value += 1
	if $ProgressBar.value == 100:
		$Timer.stop()
		potionReady()


