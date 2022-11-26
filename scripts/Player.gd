extends KinematicBody2D

export var walkingSpeed = 200
export var sprintSpeed = 300

onready var overWorld = get_node("..")

var animUp = load("res://Graphics/SpriteFrames/PlayerUp.tres") 
var animDown = load("res://Graphics/SpriteFrames/PlayerDown.tres")
var animRight = load("res://Graphics/SpriteFrames/PlayerRight.tres")
var animUpRight = load("res://Graphics/SpriteFrames/PlayerUpRight.tres")
var animDownRight = load("res://Graphics/SpriteFrames/PlayerDownRight.tres")
var speed
var action = null 

#tutorials made
var MonitTutorial = false

func _ready():
	tutHelp("Witaj w grze")

func _physics_process(_delta):
	var vel = Vector2()
	if Input.is_action_pressed("ui_sprint"):
		speed = sprintSpeed
		$PlayerAnimations.speed_scale = 2
	else:
		speed = walkingSpeed
		$PlayerAnimations.speed_scale = 1.5
	#poruszanie się lewo prawo
	if Input.is_action_pressed("ui_left"):
		vel.x -= 1
		$PlayerAnimations.frames = animRight
		$PlayerAnimations.flip_h = true
		$PlayerAnimations.playing = true
	elif Input.is_action_pressed("ui_right"):
		$PlayerAnimations.frames = animRight
		$PlayerAnimations.flip_h = false
		$PlayerAnimations.playing = true
		vel.x += 1
	else:
		$PlayerAnimations.playing = false
#pouszanie się góra dół
	if Input.is_action_pressed("ui_up"):
		vel.y -= 1
		$PlayerAnimations.frames = animUp
		$PlayerAnimations.flip_h = false
		if Input.is_action_pressed("ui_right"):
			$PlayerAnimations.frames = animUpRight
			$PlayerAnimations.flip_h = false
		if Input.is_action_pressed("ui_left"):
			$PlayerAnimations.frames = animUpRight
			$PlayerAnimations.flip_h = true

		$PlayerAnimations.playing = true
	elif Input.is_action_pressed("ui_down"):
		vel.y += 1
		$PlayerAnimations.frames = animDown
		$PlayerAnimations.playing = true
		$PlayerAnimations.flip_h = false
		if Input.is_action_pressed("ui_right"):
			$PlayerAnimations.frames = animDownRight
			$PlayerAnimations.flip_h = false
		if Input.is_action_pressed("ui_left"):
			$PlayerAnimations.frames = animDownRight
			$PlayerAnimations.flip_h = true
	vel = vel.normalized() * speed
	var _returrn = move_and_slide(vel)

func _input(_event):
	if Input.is_action_pressed("action_key"):
		print("action")
		if action != null:
			action.sendAction()

func _fixed_process():
	print(Engine.get_frames_per_second())

func changeStatus(text):
	$Status.text = text
	$Status/Timer.start()


func _on_Timer_timeout():
	$Status.text = ""
	$Status/Timer.stop()

func tutHelp(content):
	$Camera2D/Dymek.visible = true
	$Camera2D/Label.visible = true
	$Camera2D/Label.text = content
	$Camera2D/Label/Timer.start()

func _tutHelp_Timeout():
	$Camera2D/Dymek.visible = false
	$Camera2D/Label.visible = false
	$Camera2D/Label/Timer.stop()

func walkedInMonitor(monitor):
	if !MonitTutorial:
		tutHelp("Naciśnij E aby skorzystać z monitorka")
	action = get_node(monitor)