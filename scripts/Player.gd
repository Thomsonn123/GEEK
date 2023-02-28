extends KinematicBody2D

export(NodePath) var Game
export var walkingSpeed = 200
export var sprintSpeed = 300
var Robot1 = null
var hp = 100
var experiencePoints = 0
var entity = null
var money = 0
var invisibleTime = 20

#inventory
export var herbs = [0,0,0,0]
export var potions = [0,0,0,0,0,0,]
export var tools = [0]

#teleport
export(NodePath) var teleport

export(NodePath) var robot

onready var overWorld = get_node("..")
onready var mainMenu = $Main.visible
export(NodePath) var localLightPath
export(NodePath) var sun
export(NodePath) var map
export(NodePath) var AlchemistTablePath

export(NodePath) var locals1
export(NodePath) var locals2
export(NodePath) var locals3

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
var isNearWater = false
var canHit = true

#throwing
var poison = preload("res://scenes/Poison.tscn")
var poisonMelisa = preload("res://scenes/MelisaPoison.tscn")

#sounds
var normalSoundSpeed = 1.0
var sprintSoundSpeed = 1.2
var walking = preload("res://sounds/walking.mp3")
var grassWalking = preload("res://sounds/Grass.mp3")
var waterFilling = preload("res://sounds/waterFill.mp3")
var drinking = preload("res://sounds/drinking.mp3")
var robotAttack = preload("res://sounds/robotAttack.mp3")
var breakPotion = preload("res://sounds/glass.mp3")
var tooFar = load("res://sounds/tooFar.mp3")
var isOnGrass = true
var volume
var sound = 0
var currentWalking

#eq
var slots = 0
var currentSlot = 1
var canUse = true
var eq = [0,0,0,0,0,0,0,0]

#potions
var healthToAdd = 50

#tutorials made
var MonitTutorial = false
var startPosition:Vector2 = Vector2()

func _ready():
	locals1 = get_node(locals1)
	locals2 = get_node(locals2)
	locals3 = get_node(locals3)
	$Invisible.visible = false
	speed = walkingSpeed
	soundValue(0.0)
	slots = $DevTree/EqBar.get_child_count()
	$SoundPlayer.stream = currentWalking
	$Shadow/ShadowAnimations.rotation_degrees = -90
	localLight = get_node(sun)
	$DevTree.visible = false
	$RobotHackGame.visible = false
	tutHelp("Witaj w grze")
	startPosition = self.position
	
func updateAnimation():
	if sound == 0:
		currentWalking = grassWalking
	elif sound == 1:
		currentWalking = walking
	$SoundPlayer.stream = currentWalking

func _input(event):
	if Input.is_action_just_pressed("teleport"):
		#dealDamage(10)
		self.position = get_node(teleport).position
		pass
	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed() and canUse and !mainMenu:
		if eq[currentSlot-1] == 6 and isNearWater:
			$AudioEffectsPlayer.stream = waterFilling
			var length = $AudioEffectsPlayer.stream.get_length()
			$AudioEffectsPlayer/Timer.wait_time = length
			$AudioEffectsPlayer/Timer.start()
			$AudioEffectsPlayer.play()
			potions[5] -= 1
			potions[4] += 1
		elif eq[currentSlot-1] == 3:
			$AudioEffectsPlayer.stream = drinking
			var length = $AudioEffectsPlayer.stream.get_length()
			$AudioEffectsPlayer/Timer.wait_time = length
			$AudioEffectsPlayer/Timer.start()
			$AudioEffectsPlayer.play()
			potions[2] -= 1
			hp += healthToAdd
			dealDamage(0)
		elif eq[currentSlot-1] == 1 and $Menu.visible == false:
			throw(get_global_mouse_position(), self.position)
		elif eq[currentSlot-1] == 2 and $Menu.visible == false:
			throwMelisa(get_global_mouse_position(), self.position)
		elif eq[currentSlot-1] == 4 and $Menu.visible == false:
			$AudioEffectsPlayer.stream = drinking
			var length = $AudioEffectsPlayer.stream.get_length()
			$AudioEffectsPlayer/Timer.wait_time = length
			$AudioEffectsPlayer/Timer.start()
			$AudioEffectsPlayer.play()
			potions[3] -= 1
			setInvisible()

	if Input.is_action_just_pressed("WHEEL_UP") and !mainMenu:
		if currentSlot < 8:
			currentSlot += 1
		else:
			currentSlot = 1
		changeCurrentSlot(currentSlot)
	
	if Input.is_action_just_pressed("WHEEL_DOWN") and !mainMenu:
		if currentSlot > 1:
			currentSlot -= 1
		else:
			currentSlot = 8
		changeCurrentSlot(currentSlot)
	if Input.is_action_just_pressed("ui_menu") and !mainMenu:
		$Menu.visible = !$Menu.visible
		
	if Input.is_action_just_pressed("action_key") and !mainMenu:
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
		elif entity != null:
			var collect = get_node(entity)
			collect.collect()
	
	if Input.is_action_just_pressed("DevTree") and !mainMenu:
		if !$HerbalistGUI.visible:
			$DevTree.visible = !$DevTree.visible
			get_node(map).houseRev2Light(!$DevTree.visible)
			if $DevTree.visible == false:
				$DevTree.setPage(0)
				$DevTree.experiencePoints = experiencePoints
	
	if $DevTree.visible == true or $RobotHackGame.visible == true or $HerbalistGUI.visible == true or $AlchemistGUI.visible == true and $Menu.visible == true:
		canUse = false
	else:
		canUse = true
	if $HerbalistGUI.visible and action == null and !mainMenu:
		$HerbalistGUI.visible = false
		get_node(map).houseRev2Light(!$HerbalistGUI.visible)

func _physics_process(_delta):
	if mainMenu:
		mainMenu = $Main.visible
		$AudioStreamPlayer.play()
	if !mainMenu:
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
			$SoundPlayer.pitch_scale = sprintSoundSpeed
			$PlayerAnimations.speed_scale = 2
		else:
			speed = walkingSpeed
			$SoundPlayer.pitch_scale = normalSoundSpeed
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
		if $PlayerAnimations.playing and $SoundPlayer.playing == false:
			$SoundPlayer.playing = true
		if $PlayerAnimations.playing == false:
			$SoundPlayer.playing = false
		vel = vel.normalized() * speed
		var _returrn = move_and_slide(vel)
		$FPS.text = str(Engine.get_frames_per_second())


func changeStatus(text):
	$Status.text = text
	$Status/Timer.start()


func _on_Timer_timeout():
	$Status.text = ""
	$Status/Timer.stop()
	dealDamage(0)

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
 
func restartGame():
	self.position = startPosition
	hp = 100
	dealDamage(0)
	pass

func robAttack():
	canHit = false
	$AudioEffectsPlayer.stream = robotAttack
	var length = $AudioEffectsPlayer.stream.get_length()
	$AudioEffectsPlayer/Timer.wait_time = length
	$AudioEffectsPlayer/Timer.start()
	$AudioEffectsPlayer.play()

func dealDamage(value):
	if hp > 100:
		hp = 100
	elif (hp - value) < 0:
		restartGame()
	else:
		hp -= value
	$Camera2D/hp.text = str(hp)

func body_enter(body:Node):
	if "Water" in body.name:
		isNearWater = true

func body_exit(body:Node):
	if "Water" in body.name:
		isNearWater = false

func changeCurrentSlot(number):
	var position = get_node("Camera2D/EqBar/"+str(number)).position
	$Camera2D/EqBar/Actual.position = position

func eqChanged(numberOfSlot, texture, scale, hand):
	eq[numberOfSlot-1] = hand
	get_node("Camera2D/EqBar/"+str(numberOfSlot)).texture = texture
	get_node("Camera2D/EqBar/"+str(numberOfSlot)).scale = scale

func finishedPlaying():
	$AudioEffectsPlayer.stop()
	$AudioEffectsPlayer/Timer.stop()
	if !canHit:
		canHit = true

func alchemistTableSounds(value):
	get_node(AlchemistTablePath).sounds(value)

func soundValue(value):
	volume = value
	$SoundPlayer.volume_db = value
	$AudioEffectsPlayer.volume_db = value
	$Audio.volume_db = value
	get_node("DevTree/Audio").volume_db = value
	$AudioStreamPlayer.volume_db = value
	locals1.setVolume(value)
	locals2.setVolume(value)
	locals3.setVolume(value)
	var alchemist = get_node(AlchemistTablePath)
	alchemist.get_node("AudioPlayer").volume_db = value
	for i in range(1,8):
		var path = get_node(Game).find_node("Robot" + str(i)).get_path()
		get_node(path).soundValue(value)

func addMoney(value):
	money += value

func dubbing(soundd):
	$Audio.stream = soundd
	$Audio/Timer.wait_time = $Audio.stream.get_length()
	$Audio/Timer.start()

func dubbingFinished():
	$Audio/Timer.stop()
	$Audio.stop()

func throw(mousePos, playerPosition):
	var lengthToPosition = sqrt(pow((playerPosition.y - mousePos.y), 2) + pow((playerPosition.x - mousePos.x), 2))
	if potions[0] >= 1:
		if lengthToPosition <= 250:
			var instance = poison.instance()
			instance.position = self.position
			instance.init(playerPosition, mousePos, breakPotion, volume, speed)
			get_tree().get_root().add_child(instance)
			potions[0] -= 1
		else:
			dubbing(tooFar)
	pass
func throwMelisa(mousePos, playerPosition):
	var lengthToPosition = sqrt(pow((playerPosition.y - mousePos.y), 2) + pow((playerPosition.x - mousePos.x), 2))
	if potions[0] >= 1:
		if lengthToPosition <= 250:
			var instance = poisonMelisa.instance()
			instance.position = self.position
			instance.init(playerPosition, mousePos, breakPotion, volume, speed)
			get_tree().get_root().add_child(instance)
			potions[1] -= 1
		else:
			dubbing(tooFar)

func setInvisible():
	$Invisible/Timer.wait_time = invisibleTime / 10
	$Invisible.visible = true
	$Invisible/ProgressBar.value = 0
	$Invisible/ProgressBar.max_value = 10
	$Invisible/Timer.start()

func invisibleTick():
	if $Invisible/ProgressBar.value < $Invisible/ProgressBar.max_value:
		invisible = true
		$Invisible/Timer.start()
		$Invisible/ProgressBar.value += 1
	else:
		$Invisible.visible = false
		invisible = false
		$Invisible/Timer.stop()

