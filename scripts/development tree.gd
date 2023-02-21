extends Node2D

export(NodePath) var robotHacks
export(NodePath) var Player
var curPage = 0
var rHack
var experiencePoints = 0
onready var MenuPage = get_node("Menu")
onready var HackingSkills = get_node("HackingSkills")
onready var Eq = get_node("Eq")
var buttonsPrice = [100, 500, 100]
var clickedButtons = [false, false, false]

func _ready():
	rHack = get_node(robotHacks)
	update()

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
	elif curPage == 1:
		$MenuButton.visible = true
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = true
		Eq.visible = false
	elif curPage == 2:
		$MenuButton.visible = true
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = false
		Eq.visible = true
		$Eq/Melisa.text = "Melisa: " + str(get_node(Player).herbs[0])
		$Eq/Dandelion.text = "Mniszek lekarski: " + str(get_node(Player).herbs[1])
		$Eq/Poppy.text = "Mak: " + str(get_node(Player).herbs[2])
		$Eq/Apple.text = "Jabłko: " + str(get_node(Player).herbs[3])
		$Eq/Health.text = "Lekarstwo: " + str(get_node(Player).potions[2])
		$Eq/Invisible.text = "Trucizna: " + str(get_node(Player).potions[3])
		$Eq/Melisa2.text = "Melisa: " + str(get_node(Player).potions[1])
		$Eq/Vinegar.text = "Ocet: " + str(get_node(Player).potions[0])


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
