extends Node2D

var curPage = 0
onready var MenuPage = get_node("Menu")
onready var CombatPage = get_node("CombatSkills")
onready var WeaponPage = get_node("WeaponSkills")

func _process(_delta):
	if curPage == 0:
		$Page.text = " "
		MenuPage.visible = true
	elif curPage == 1:
		$Page.text = str(curPage)
        MenuPage.visible = false
        CombatPage.visible = true
	elif curPage == 2:
		$Page.text = str(curPage)
        MenuPage.visible = false


func _on_CombatSkills_pressed():
	curPage = 1


func _on_WeaponsSkills_pressed():
	curPage = 2
