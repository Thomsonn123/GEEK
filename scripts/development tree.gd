extends Node2D

export(NodePath) var robotHacks = null

var curPage = 0
onready var MenuPage = get_node("Menu")
onready var CombatPage = get_node("CombatSkills")
onready var WeaponPage = get_node("WeaponSkills")
onready var HackingSkills = get_node("HackingSkills")

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


	
func setPage(page):
	curPage = page
func _on_CombatSkills_pressed():
	curPage = 1
func _on_WeaponsSkills_pressed():
	curPage = 2
func _on_MenuButton_pressed():
	curPage = 0

func hackingSkills(skills):
	if skills == "speed":
		robotHacks.upgradeHackingSpeed(1)
	elif skills == "maxTiles":
		robotHacks.upgradeHackingTiles(1)
	elif skills == "type":
		robotHacks.setTypeOfAttack()