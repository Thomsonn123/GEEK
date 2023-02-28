extends KinematicBody2D

export var position1 = Vector2()
export var position2 = Vector2()

var moveTo
var walking = load("res://sounds/Grass.mp3")

var animright = load("res://Graphics/SpriteFrames/localsRight.tres")
var animup = load("res://Graphics/SpriteFrames/localsup.tres")
var animdown = load("res://Graphics/SpriteFrames/localsDown.tres")

func _ready():
	moveTo = position2
	changeAnimation(moveTo)
	$AudioStreamPlayer2D.stream = walking
	$AudioStreamPlayer2D.play()

func setVolume(value):
	$AudioStreamPlayer2D.volume_db = value

func _physics_process(delta):
	if moveTo == position2 and self.position == position2:
		moveTo = position1
		changeAnimation(moveTo)
	elif moveTo == position1 and self.position == position1:
		moveTo = position2
		changeAnimation(moveTo)
	self.position = position.move_toward(moveTo, delta * 100)

func changeAnimation(positionTo):
	var degrees = rad2deg(self.get_angle_to(positionTo))
	if degrees > 0:
		if degrees < 45:
			$AnimatedSprite.frames = animright
			$AnimatedSprite.flip_h = false
		elif degrees > 45 and degrees < 135:
			$AnimatedSprite.frames = animdown
		elif degrees > 135:
			$AnimatedSprite.frames = animright
			$AnimatedSprite.flip_h = true
	elif degrees < 0:
		if degrees > -45:
			$AnimatedSprite.frames = animright
			$AnimatedSprite.flip_h = false
		elif degrees < -45 and degrees > -135:
			$AnimatedSprite.frames = animup
		elif degrees < -135:
			$AnimatedSprite.frames = animright
			$AnimatedSprite.flip_h = true
	$AnimatedSprite.play()
