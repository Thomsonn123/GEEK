extends KinematicBody2D


export var place1 = Vector2()
export var place2 = Vector2()
export var walkingSpeed = 100
export var sprintSpeed = 200
var hackingTimeDelay = 10
var damage = 10
var PlayerInCollision
export var seePlayer = false
var walking = false
var movePosition = place1
var lastMove
var lastPosition = null
var reversion = false
var isDay = true
var localLight
var attack = false


export var isHacked = false
export(NodePath) var sun
onready var player = get_node("../../Player")
var walkingSound = preload("res://sounds/robotWalking.mp3")

var robotUp = load("res://Graphics/SpriteFrames/RobotUp.tres")
var robotDown = load("res://Graphics/SpriteFrames/RobotDown.tres")
var robotLeft = load("res://Graphics/SpriteFrames/RobotLeft.tres")
var robotdownBevel = load("res://Graphics/SpriteFrames/RobotDownBevel.tres")
var robotUpBevel = load("res://Graphics/SpriteFrames/RobotUpBevel.tres")

var robotRustUp = load("res://Graphics/SpriteFrames/RobotRustUp.tres")
var robotRustDown = load("res://Graphics/SpriteFrames/RobotRustDown.tres")
var robotRustLeft = load("res://Graphics/SpriteFrames/RobotRustLeft.tres")
var lastDegrees = 0
var walkingDirection = "left"
var poisoned = false

func _ready():
	$Shadow.rotation_degrees = -90
	walking = true
	self.position = place2
	$AudioPlayer.stream = walkingSound
	$AudioPlayer.pitch_scale = 0.6
	$AudioPlayer.play()

func _process(delta):

	if isDay:
		localLight = get_node(sun)
	if isHacked:
		$AnimatedSprite.stop()
		$AudioPlayer.stop()
	elif attack:
		self.position = self.position
		if player.canHit:
			player.dealDamage(10)
			player.robAttack()
		#checkWalking(player.position)
	elif seePlayer:
		if $AudioPlayer.pitch_scale != 0.8:
			$AudioPlayer.pitch_scale = 0.8
		self.position = position.move_toward(player.position, delta * 200)
		checkWalking(player.position)
	else:
		if $AudioPlayer.pitch_scale != 0.6:
			$AudioPlayer.pitch_scale = 0.6
		if lastPosition != null and reversion:
			movePosition = lastPosition
			reversion = false
		elif poisoned:
			self.position = self.position
		elif lastPosition != null and self.position == lastPosition:
			movePosition = lastMove
			lastPosition = null
			lastMove = null
		elif self.position == place1:
			movePosition = place2
		elif self.position == place2:
			movePosition = place1
		self.position = position.move_toward(movePosition, delta * 100)
		checkWalking(movePosition)
	$Shadow.look_at(localLight.global_position)

func checkWalking(positionTo):
	var degrees = rad2deg(self.get_angle_to(positionTo))
	print(degrees)
	if degrees > 0:
		if degrees < 22.5:
			walkingRight()
		elif degrees > 22.5 and degrees < 67.5:
			walkingBevelRightDown()
		elif degrees > 67.5 and degrees < 112.5:
			walkingDown()
		elif degrees > 112.5 and degrees < 157.5:
			walkingBevelLeftDown()
		elif degrees > 157.5:
			walkingLeft()
	elif degrees < 0:
		if degrees > -22.5:
			walkingRight()
		elif degrees < -22.5 and degrees > -67.5:
			walkingBevelRightUp()
		elif degrees < -67.5 and degrees > -112.5:
			walkingUp()
		elif degrees < -112.5 and degrees > -157.5:
			walkingBevelLeftUp()
		elif degrees < -157.5:
			walkingLeft()


func walkingBevelRightUp():
	if walkingDirection != "rightup":
		$AnimatedSprite.frames = robotUpBevel
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play()
		walkingDirection = "rightup"

func walkingBevelLeftUp():
	if walkingDirection != "leftup":
		$AnimatedSprite.frames = robotUpBevel
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play()
		walkingDirection = "leftup"

func walkingBevelRightDown():
	if walkingDirection != "rightdown":
		$AnimatedSprite.frames = robotdownBevel
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play()
		walkingDirection = "rightdown"

func walkingBevelLeftDown():
	if walkingDirection != "leftdown":
		$AnimatedSprite.frames = robotdownBevel
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play()
		walkingDirection = "leftdown"

func walkingUp():
	if walkingDirection != "up":
		$AnimatedSprite.frames = robotUp
		$AnimatedSprite.play()
		walkingDirection = "up"

func walkingDown():
	if walkingDirection != "down":
		$AnimatedSprite.frames = robotDown
		$AnimatedSprite.play()
		walkingDirection = "down"

func walkingLeft():
	if walkingDirection != "left":
		$AnimatedSprite.frames = robotLeft
		$AnimatedSprite.play()
		$AnimatedSprite.flip_h = false
		walkingDirection = "left"

func walkingRight():
	if walkingDirection != "right":
		walkingLeft()
		$AnimatedSprite.flip_h = true
		walkingDirection = "right"

func soundValue(value):
	$AudioPlayer.volume_db = value

func _on_Area2D_body_entered(body:Node):
	if body.name == "Player":
		lastPosition = Vector2(stepify(self.position.x, 0.01), stepify(self.position.y, 0.01))
		if movePosition == place1 or movePosition == place2:
			lastMove = movePosition
		seePlayer = true

func _on_Area2D_body_exited(body:Node):
	if body.name == "Player":
		seePlayer = false
		reversion = true

func hacked():
	isHacked = true

func walkInPlayerAttack(body:Node):
	if body.name == "Player" and player.invisible == false:
		attack = true

func walkOutPlayerAttack(body:Node):
	if body.name == "Player" or player.invisible == true:
		attack = false
		
func attackedByPlayer():
	var rng = RandomNumberGenerator.new()
	randomize()
	var random = rng.randi_range(100, 500)
	player.addMoney(random)
	poisoned = true
	$AnimatedSprite.frames = robotRustDown
	$AnimatedSprite.play()
