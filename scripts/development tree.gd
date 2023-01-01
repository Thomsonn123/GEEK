extends Node2D

export(NodePath) var robotHacks

var curPage = 0
var rHack
var experiencePoints = 0
onready var MenuPage = get_node("Menu")
onready var CombatPage = get_node("CombatSkills")
onready var WeaponPage = get_node("WeaponSkills")
onready var HackingSkills = get_node("HackingSkills")

func _ready():
	rHack = get_node(robotHacks)

func _process(_delta):
	$MenuButton.visible = !MenuPage.visible
	if curPage == 0:
		$Page.text = ""
		MenuPage.visible = true
	elif curPage == 1:
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = true
		CombatPage.visible = false
		WeaponPage.visible = false

	elif curPage == 2:
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = false
		CombatPage.visible = true
		WeaponPage.visible = false

	elif curPage == 3:
		$Page.text = str(curPage)
		MenuPage.visible = false
		HackingSkills.visible = false
		CombatPage.visible = false
		WeaponPage.visible = true
	
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
	pass # Replace with function body.
