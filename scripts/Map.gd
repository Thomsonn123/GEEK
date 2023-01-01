extends Node2D

export(NodePath) var sun

func _ready():
    var light = get_node(sun)
    $Woods/Pines1/Pine.localLight = light