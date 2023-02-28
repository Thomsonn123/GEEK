extends Node2D

export(NodePath) var sun

func _ready():
    $Water2/AudioStreamPlayer2D.play()
    $Water3/AudioStreamPlayer2D.play()
    $Water4/AudioStreamPlayer2D.play()
    var light = get_node(sun)
    $Woods/Pines1/Pine.localLight = light

func houseRev2Light(value):
    $HouseRev2/Light2D.visible = value