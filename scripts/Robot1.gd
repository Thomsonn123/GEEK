extends KinematicBody2D


export var place1 = Vector2()
export var place2 = Vector2()
export var walkingSpeed = 100
export var sprintSpeed = 200

export var seePlayer = false
var walking = false

var movePosition = place1
var lastMove
var lastPosition = null
var reversion = false
var isHacked = false

onready var player = get_node("../Player")

func _ready():
	walking = true

func _process(delta):
	if isHacked:
		pass
	elif seePlayer:
		self.position = position.move_toward(player.position, delta * sprintSpeed)
	else:
		if lastPosition != null and reversion:
			movePosition = lastPosition
			reversion = false
		elif lastPosition != null and self.position == lastPosition:
			print("work")
			movePosition = lastMove
			lastPosition = null
			lastMove = null
		elif self.position == place1:
			movePosition = place2
		elif self.position == place2:
			movePosition = place1
		self.position = position.move_toward(movePosition, delta * walkingSpeed)
	

func _on_Area2D_body_entered(body:Node):
	if body.name == "Player":
		lastPosition = Vector2(stepify(self.position.x, 0.01), stepify(self.position.y, 0.01))
		lastMove = movePosition
		seePlayer = true

func _on_Area2D_body_exited(body:Node):
	if body.name == "Player":
		seePlayer = false
		reversion = true

func hacked():
	isHacked = true