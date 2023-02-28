extends Node2D

#dubbing

var eqDubbing = load("res://sounds/ekwipunek.mp3")
var skillsDubbing = load("res://sounds/umiejetnosci.mp3")
var mapDubbing = load("res://sounds/mapa.mp3")

var isDubbing = [0,0,0]


export(NodePath) var robotHacks
export(NodePath) var Player
var curPage = 0
var rHack
var experiencePoints = 0
onready var MenuPage = get_node("Menu")
onready var HackingSkills = get_node("HackingSkills")
onready var Eq = get_node("Eq")
onready var Map = get_node("Map")
var buttonsPrice = [100, 500, 100]
var clickedButtons = [false, false, false]

#Eq bar
var imagePrefix = "res://Graphics/Alchemist/Potions/"
var eq = [0,0,0,0,0,0,0,0,0]
var item = 0
var hand = 0
var slot = 0
var images = ["vinegar.png", "melisaPotion.png", "health.png", "invisible.png", "water.png", "empty.png"]

#map
var pressed = false
var active_line = null

func _ready():
	get_node("HackingSkills/1price").text = str(buttonsPrice[0])
	get_node("HackingSkills/2price").text = str(buttonsPrice[1])
	get_node("HackingSkills/3price").text = str(buttonsPrice[2])
	rHack = get_node(robotHacks)
	update()

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		if item != 0:
			hand = item
		elif not slot == 0 and not hand in eq and get_node(Player).potions[hand-1] > 0:
			eq[slot] = hand
			eqChanged(slot, hand)
			hand = 0
		elif eq[slot] != 0 and hand == 0:
			eq[slot] = 0
			eqChanged(slot, hand)
		elif hand != 0 and item == 0:
			hand = 0

func eqChanged(slotToChange, handToChange):
	var texture = ImageTexture.new()
	var scale = Vector2(1,1)
	if hand != 0:
		var path = imagePrefix + images[handToChange - 1]
		var imageTexture = load(path)
		var image = imageTexture.get_data()
		texture = ImageTexture.new()
		texture.create_from_image(image, 0)
		var sizeTo = Vector2(80,80)
		var size = texture.get_size()
		scale = sizeTo/size
	else:
		texture = null
	get_node("EqBar/Slot"+str(slotToChange)+"/Sprite").scale = scale
	get_node("EqBar/Slot"+str(slotToChange)+"/Sprite").texture = texture
	get_node(Player).eqChanged(slotToChange, texture, scale, handToChange)


func update():
	if get_node(Player).money >= buttonsPrice[0]:
		$HackingSkills/base.disabled = clickedButtons[0]
	else:
		$HackingSkills/base.disabled = true
	if get_node(Player).money >= buttonsPrice[1] and clickedButtons[0] == true:
		$HackingSkills/ManualSkills/AutoCollect.disabled = clickedButtons[1]
	else:
		$HackingSkills/ManualSkills/AutoCollect.disabled = true
	if get_node(Player).money >= buttonsPrice[2] and clickedButtons[1] == true:
		$HackingSkills/ManualSkills/TreeAutoCollect.disabled = clickedButtons[2]
	else:
		$HackingSkills/ManualSkills/TreeAutoCollect.disabled = true
	
	if curPage == 0:
		$MenuButton.visible = false
		$Page.text = ""
		HackingSkills.visible = false
		Eq.visible = false
		MenuPage.visible = true
		Map.visible = false
	elif curPage == 1:
		if isDubbing[0] == 0:
			$Audio.stream = skillsDubbing
			$Audio/Timer.wait_time = $Audio.stream.get_length()
			$Audio/Timer.start()
			$Audio.play()
			isDubbing[0] = 1
		$MenuButton.visible = true
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = true
		Eq.visible = false
		Map.visible = false
	elif curPage == 2:
		if isDubbing[1] == 0:
			$Audio.stream = eqDubbing
			$Audio/Timer.wait_time = $Audio.stream.get_length()
			$Audio/Timer.start()
			$Audio.play()
			isDubbing[1] = 1
		$MenuButton.visible = true
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = false
		Eq.visible = true
		Map.visible = false
		$Eq/Melisa.text = "Melisa: " + str(get_node(Player).herbs[0])
		$Eq/Dandelion.text = "Mniszek lekarski: " + str(get_node(Player).herbs[1])
		$Eq/Poppy.text = "Mak: " + str(get_node(Player).herbs[2])
		$Eq/Apple.text = "Jabłko: " + str(get_node(Player).herbs[3])
		$Eq/Health.text = "Lekarstwo: " + str(get_node(Player).potions[2])
		$Eq/Invisible.text = "Niewidzialność: " + str(get_node(Player).potions[3])
		$Eq/Melisa2.text = "Melisa: " + str(get_node(Player).potions[1])
		$Eq/Vinegar.text = "Ocet: " + str(get_node(Player).potions[0])
		$Eq/Water.text = "Woda: " + str(get_node(Player).potions[4])
		$Eq/Empty.text = "Pusta butelka: " + str(get_node(Player).potions[5])
		$EqBar.visible = $Eq.visible
	elif curPage == 3:
		if isDubbing[2] == 0:
			$Audio.stream = mapDubbing
			$Audio/Timer.wait_time = $Audio.stream.get_length()
			$Audio/Timer.start()
			$Audio.play()
			isDubbing[2] = 1
		$MenuButton.visible = true
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = false
		Eq.visible = false
		Map.visible = true
	$EqBar.visible = $Eq.visible
		

func clicked(name):
	if name == "Base":
		get_node(Player).money -= buttonsPrice[0]
		clickedButtons[0] = true
	elif name == "autoCollect":
		get_node(Player).money -= buttonsPrice[1]
		clickedButtons[1] = true
		get_node(Player).autocollect = true
	elif name == "treeAutoCollect":
		get_node(Player).money -= buttonsPrice[2]
		clickedButtons[2] = true
		get_node(Player).treeAutocollect = true
	update()

func setPage(page):
	curPage = page
	update()

func _on_CombatSkills_pressed():
	curPage = 1
	update()

func _on_MenuButton_pressed():
	curPage = 0
	update()

func _on_HackingSkills_pressed():
	curPage = 2
	update()

func _on_Map_pressed():
	curPage = 3
	update()

func changeItem(value=0):
	item = value

func changeSlot(value):
	slot = value

func MapDrawing(_viewport:Node, event:InputEvent, _shape_idx:int):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			pressed = true
			active_line = Line2D.new()
			active_line.default_color = Color("#453938")
			active_line.width = 5.0
			get_node("Map/lines").add_child(active_line)
		else:
			pressed = false
	if event is InputEventMouseMotion:
		if pressed:
			active_line.add_point(event.position)

func deleteLastLine():
	var childs = get_node("Map/lines").get_children()
	if childs.size() != 0:
		var last = childs.pop_back()
		get_node("Map/lines/" + str(last.name)).queue_free()

func turnOff():
	$Audio.stop()
	$Audio/Timer.stop()
