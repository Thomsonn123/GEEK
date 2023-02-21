extends Node2D

export(NodePath) var robotHacks
export(NodePath) var Player
var curPage = 0
var rHack
var experiencePoints = 0
onready var MenuPage = get_node("Menu")
onready var HackingSkills = get_node("HackingSkills")
onready var Eq = get_node("Eq")

func _ready():
	rHack = get_node(robotHacks)
	update()

func update():
	
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
		$Eq/Health.text = "Lekarstwo: " + str(get_node(Player).potions[2])
		$Eq/Invisible.text = "Trucizna: " + str(get_node(Player).potions[3])
		$Eq/Melisa2.text = "Melisa: " + str(get_node(Player).potions[1])
		$Eq/Vinegar.text = "Ocet: " + str(get_node(Player).potions[0])


func clicked(name, value):
	if experiencePoints >= value:
		if name == "Base":
			experiencePoints -= value
			$HackingSkills/Speed/speed.disabled = false
			$HackingSkills/Combat/base.disabled = false
			$HackingSkills/HackingType/base2.disabled = false
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
