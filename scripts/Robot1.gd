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
		pass
	elif attack:
		self.position = self.position
		if player.canHit:
			player.dealDamage(10)
			player.robAttack()
	elif seePlayer:
		if $AudioPlayer.pitch_scale != 0.8:
			$AudioPlayer.pitch_scale = 0.8
		self.position = position.move_toward(player.position, delta * sprintSpeed)
	else:
		if $AudioPlayer.pitch_scale != 0.6:
			$AudioPlayer.pitch_scale = 0.6
		if lastPosition != null and reversion:
			movePosition = lastPosition
			reversion = false
		elif lastPosition != null and self.position == lastPosition:
			movePosition = lastMove
			lastPosition = null
			lastMove = null
		elif self.position == place1:
			movePosition = place2
		elif self.position == place2:
			movePosition = place1
		self.position = position.move_toward(movePosition, delta * walkingSpeed)
	$Shadow.look_at(localLight.global_position)

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
		
