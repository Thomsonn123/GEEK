extends Node2D

export var curPage = 1

onready var MenuPage = $Menu

func _fixed_process(_delta):
    $Label.text = str(curPage)