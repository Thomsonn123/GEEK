extends Node2D

export(NodePath) var robotHacks
export(NodePath) var Player
var curPage = 0
var rHack
var experiencePoints = 0
onready var MenuPage = get_node("Menu")
onready var CombatPage = get_node("CombatSkills")
onready var WeaponPage = get_node("WeaponSkills")
onready var HackingSkills = get_node("HackingSkills")
onready var Eq = get_node("Eq")

func _ready():
	rHack = get_node(robotHacks)

func _process(_delta):
	$MenuButton.visible = !MenuPage.visible
	if curPage == 0:
		$Page.text = ""
		HackingSkills.visible = false
		CombatPage.visible = false
		WeaponPage.visible = false
		Eq.visible = false
		MenuPage.visible = true
	elif curPage == 1:
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = true
		CombatPage.visible = false
		WeaponPage.visible = false
		Eq.visible = false

	elif curPage == 2:
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = false
		CombatPage.visible = true
		WeaponPage.visible = false
		Eq.visible = false

	elif curPage == 3:
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = false
		CombatPage.visible = false
		WeaponPage.visible = true
		Eq.visible = false
	
	elif curPage == 4:
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = false
		CombatPage.visible = false
		WeaponPage.visible = false
		Eq.visible = true
		$Eq/Melisa.text = "Melisa: " + str(get_node(Player).herbs[0])
		$Eq/Dandelion.text = "Mniszek lekarski: " + str(get_node(Player).herbs[1])
		$Eq/Poppy.text = "Mak: " + str(get_node(Player).herbs[2])

func clicked(name, value):
	if experiencePoints >= value:
		if name == "Base":
			experiencePoints -= value
			$HackingSkills/Speed/speed.disabled = false
			$HackingSkills/Combat/base.disabled = false
			$HackingSkills/HackingType/base2.disabled = false
		
	
func setPage(page):
	curPage = page
func _on_CombatSkills_pressed():
	curPage = 1
func _on_WeaponsSkills_pressed():
	curPage = 2
func _on_MenuButton_pressed():
	curPage = 0
func _on_HackingSkills_pressed():
	curPage = 4
