extends Node2D

var PlayerStartPosition = Vector2(-3008, 1152)

#onready var DayNightCycle = get_node("DayNight/CanvasModulate")
var flowers = 0

var nightColorA = 1.0
var nightColorR = 0.30
var nightColorG = 0.30
var nightColorB = 0.30

var dayColorA = 1.0
var dayColorR = 0.9
var dayColorG = 0.9
var dayColorB = 0.9

var currentColorA
var currentColorR
var currentColorG
var currentColorB

export var isNight = false

func _ready():
	flowers +=$Melisa.get_child_count() + $Dandelion.get_child_count() + $Poppy.get_child_count()
	startGame()
	#$DayNight/ChangeTimer.start()
	#currentColorA = dayColorA
	#currentColorR = dayColorR
	#currentColorG = dayColorG
	#currentColorB = dayColorB

func startGame():
	$Player.position = PlayerStartPosition

func restartGame():
	$Player.changeStatus("Zaczynasz od nowa")
	startGame()
func _physics_process(_delta):
	#print(Engine.get_frames_per_second())
	pass

func NightAdd():
	if nightColorR < currentColorR:
		currentColorR -= 0.05
	if nightColorG < currentColorG:
		currentColorG -= 0.05
	if nightColorB < currentColorB:
		currentColorB -= 0.05
	if nightColorR >= currentColorR && nightColorG >= currentColorG && nightColorB >= currentColorB:
		$DayNight/NightTimer.stop()
		$DayNight/ChangeTimer.start()
	updateDayCycle()

func DayAdd():
	if dayColorR > currentColorR:
		currentColorR += 0.05
	if dayColorG > currentColorG:
		currentColorG += 0.05
	if dayColorB > currentColorB:
		currentColorB += 0.05
	if dayColorR <= currentColorR && dayColorG <= currentColorG && dayColorB <= currentColorB:
		$DayNight/DayTimer.stop()
		$DayNight/ChangeTimer.start()
	updateDayCycle()

func change():
	$DayNight/ChangeTimer.stop()
	if isNight:
		$DayNight/DayTimer.start()
		isNight = false
	else:
		$DayNight/NightTimer.start()
		isNight = true
	

func updateDayCycle():
	#var newColor = Color(currentColorR,currentColorG,currentColorB,nightColorA)
	#DayNightCycle.color = newColor
	pass
