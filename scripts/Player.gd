extends KinematicBody2D

export var walkingSpeed = 200
export var sprintSpeed = 300
var Robot1 = null
var hp = 100
var experiencePoints = 0
var entity = null
var money = 0

#inventory
export var herbs = [0,0,0,0]
export var potions = [0,0,0,0]
export var tools = [0]

#teleport
export(NodePath) var teleport


onready var overWorld = get_node("..")
export(NodePath) var localLightPath
export(NodePath) var sun
export(NodePath) var map

var animUp = preload("res://Graphics/SpriteFrames/PlayerUp.tres") 
var animDown = preload("res://Graphics/SpriteFrames/PlayerDown.tres")
var animRight = preload("res://Graphics/SpriteFrames/PlayerRight.tres")
var animUpRight = preload("res://Graphics/SpriteFrames/PlayerUpRight.tres")
var animDownRight = preload("res://Graphics/SpriteFrames/PlayerDownRight.tres")
var speed
var action = null 
var actionName = null
var localLight
var isDay = true
var invisible = false
var autocollect = false
var treeAutocollect = false

#tutorials made
var MonitTutorial = false
var startPosition:Vector2 = Vector2()

func _ready():
	$Shadow/ShadowAnimations.rotation_degrees = -90
	localLight = get_node(sun)
	$DevTree.visible = false
	$RobotHackGame.visible = false
	tutHelp("Witaj w grze")
	startPosition = self.position

func _input(_event):
	if Input.is_action_just_pressed("teleport"):
		self.position = get_node(teleport).position
	if Input.is_action_just_pressed("action_key"):
		if action != null and "Monitor" in actionName:
			$RobotHackGame.start()
		elif action != null and "Herbalist" in actionName:
			$HerbalistGUI.visible = !$HerbalistGUI.visible
			$HerbalistGUI.open()
			get_node(map).houseRev2Light(!$HerbalistGUI.visible)
		elif action != null and "Alchemist" in actionName:
			$AlchemistGUI.visible = !$AlchemistGUI.visible
			if $AlchemistGUI.visible == true:
				$AlchemistGUI.open()
				print("true")
		elif entity != null:
			var collect = get_node(entity)
			collect.collect()
	
	if Input.is_action_just_pressed("DevTree"):
		if !$HerbalistGUI.visible:
			$DevTree.visible = !$DevTree.visible
			get_node(map).houseRev2Light(!$DevTree.visible)
			if $DevTree.visible == false:
				$DevTree.setPage(0)
				$DevTree.experiencePoints = experiencePoints
	if $HerbalistGUI.visible and action == null:
		$HerbalistGUI.visible = false
		get_node(map).houseRev2Light(!$HerbalistGUI.visible)

func _physics_process(_delta):
	$Money.text = str(money)
	$Shadow/ShadowAnimations.frames = $PlayerAnimations.frames
	$Shadow/ShadowAnimations.frame = $PlayerAnimations.frame
	$Shadow/ShadowAnimations.speed_scale = $PlayerAnimations.speed_scale
	$Shadow/ShadowAnimations.playing = $PlayerAnimations.playing
	if localLight != null:
		$Shadow.look_at(localLight.global_position)
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
		$Shadow/ShadowAnimations.flip_h = true
		$Shadow/ShadowAnimations.flip_h = false
		$PlayerAnimations.flip_h = true
		$PlayerAnimations.playing = true
	elif Input.is_action_pressed("ui_right"):
		$PlayerAnimations.frames = animRight
		$PlayerAnimations.flip_h = false
		$Shadow/ShadowAnimations.flip_h = true
		$PlayerAnimations.playing = true
		vel.x += 1
	else:
		if $PlayerAnimations.frames == animRight:
			$PlayerAnimations.frame = 12
		$PlayerAnimations.playing = false

#pouszanie się góra dół
	if Input.is_action_pressed("ui_up"):
		vel.y -= 1
		$PlayerAnimations.frames = animUp
		$PlayerAnimations.flip_h = false
		$Shadow/ShadowAnimations.flip_h = true
		if Input.is_action_pressed("ui_right"):
			$PlayerAnimations.frames = animUpRight
			$PlayerAnimations.flip_h = false
			$Shadow/ShadowAnimations.flip_h = true
		if Input.is_action_pressed("ui_left"):
			$PlayerAnimations.frames = animUpRight
			$PlayerAnimations.flip_h = true		
			$Shadow/ShadowAnimations.flip_h = false
		$PlayerAnimations.playing = true
	elif Input.is_action_pressed("ui_down"):
		vel.y += 1
		$PlayerAnimations.frames = animDown
		$PlayerAnimations.playing = true
		$PlayerAnimations.flip_h = false
		$Shadow/ShadowAnimations.flip_h = true
		if Input.is_action_pressed("ui_right"):
			$PlayerAnimations.frames = animDownRight
		if Input.is_action_pressed("ui_left"):
			$PlayerAnimations.frames = animDownRight
			$PlayerAnimations.flip_h = true
			$Shadow/ShadowAnimations.flip_h = false
	else:
		if $PlayerAnimations.frames == animDown:
			$PlayerAnimations.frame = 30
		elif $PlayerAnimations.frames == animUp:
			$PlayerAnimations.frame = 30
		elif $PlayerAnimations.frames == animUpRight:
			$PlayerAnimations.frame = 12
		elif $PlayerAnimations.frames == animDownRight:
			$PlayerAnimations.frame = 12

	vel = vel.normalized() * speed
	var _returrn = move_and_slide(vel)
	$FPS.text = str(Engine.get_frames_per_second())


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

func walkedInMonitor(monitor, name, robotpath):
	if !MonitTutorial:
		tutHelp("Naciśnij E aby skorzystać z monitorka")
	action = get_node(monitor)
	actionName = name
	Robot1 = robotpath
	$RobotHackGame.robot = Robot1

func bodyOut():
	action = null 
	actionName = null
	Robot1 = null
	$RobotHackGame.visible = false
	$RobotHackGame.robot = null

func add(value):
	if value == "Melisa":
		herbs[0] += 1
	elif value == "Dandelion":
		herbs[1] += 1
	elif value == "Poppy":
		herbs[2] += 1
	elif value == "Apple":
		herbs[3] += 1
	print(herbs)
 
func restartGame():
	
	pass

func dealDamage(value):
	hp -= value

func body_enter(body:Node):
	if "Water" in body.name:
		print(body.name)
