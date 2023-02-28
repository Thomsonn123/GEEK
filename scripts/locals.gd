extends KinematicBody2D

export var position1 = Vector2()
export var position2 = Vector2()

var moveTo
var walking = load("res://sounds/Grass.mp3")

func _ready():
    moveTo = position2

func _physics_process(delta):
    if moveTo == position2 and self.position == position2:
        moveTo = position1
    elif moveTo == position1 and self.position == position1:
        moveTo = position2
    self.position = position.move_toward(moveTo, delta * 100)