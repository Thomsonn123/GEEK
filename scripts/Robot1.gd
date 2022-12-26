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


export var isHacked = false
export(NodePath) var sun
onready var player = get_node("../../Player")

func _ready():
	$Shadow.rotation_degrees = -90
	walking = true
	self.position = place2


func _process(delta):
	if isDay:
		localLight = get_node(sun)
	if isHacked:
		pass
	elif seePlayer:
		self.position = position.move_toward(player.position, delta * sprintSpeed)
	else:
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

func timeHacked():
	$HackingTimer.wait_time = hackingTimeDelay
	$HackingTimer.start()
	isHacked = true

func hackingTimerTimeout():
	isHacked = false
	$HackingTimer.stop()

		
