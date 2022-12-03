extends Node2D

var curPage = 0
onready var MenuPage = get_node("Menu")

func _process(_delta):
	if curPage == 0:
		$Page.text = " "
		MenuPage.visible = true
