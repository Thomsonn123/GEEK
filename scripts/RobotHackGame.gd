extends Node2D


export var hackingTime = 10
export var tilesShowTime = 1
export var maxTiles = 4
var showedTiles = 0
var morePointsSkills = 0.3
var changeSpeed = 0.1
export var attackType = 1
export var experiencePointsAfterHacking = 100
export(NodePath) var player

var robot = null
var tileContainer = null
var tileContainerChildCount = null

var themeBlue = load("res://ButtonThemes/Tile.tres")
var themeNormal = load("res://ButtonThemes/Normal.tres")

func setHackingTime(value):
	hackingTime = value
func setTilesShowTime(value):
	tilesShowTime = value
func setMaxTiles(value):
	maxTiles = value

func _ready():
	print(hackingTime)
	$ProgressBar.max_value = hackingTime
	tileContainer = get_node("Buttons")
	tileContainerChildCount = tileContainer.get_child_count()
	$GameTimer.wait_time = hackingTime

func _physics_process(_delta):
	if showedTiles >= maxTiles:
		stopGame()
	$ProgressBar.value = $GameTimer.time_left

func start():
	self.visible = !self.visible
	if self.visible == true:
		$Button.visible = true
	else:
		stopGame()

func startHacking():	
	$Button.visible = false
	$Timer.start()
	$GameTimer.start()

func ShowNewTile():
	randomize()
	var random = rand_range(0,tileContainerChildCount)
	var ButtonToColorize = tileContainer.get_child(random)
	ButtonToColorize.add_stylebox_override("normal", themeBlue)
	ButtonToColorize.add_stylebox_override("hover", themeBlue)
	showedTiles += 1

func unColor(objectName):
	showedTiles -= 1
	var object = get_node("Buttons/" + objectName)
	object.add_stylebox_override("hover", themeNormal)
	object.add_stylebox_override("normal", themeNormal)

func timerTick():
	ShowNewTile()

func _on_GameTimer_timeout():
	finishHack()
	
func restartGame():
	for i in range(0, tileContainerChildCount):
		var ButtonToColorize = tileContainer.get_child(i)
		ButtonToColorize.add_stylebox_override("normal", themeNormal)
		ButtonToColorize.add_stylebox_override("hover", themeNormal)
	showedTiles = 0
	$GameTimer.wait_time = hackingTime
	$Timer.start()

func finishHack():
	var rng = RandomNumberGenerator.new()
	var random = rng.randi_range(100,500)
	get_node(player).addMoney(random)
	get_node(player).experiencePoints += experiencePointsAfterHacking
	hackedGame()
	$GameTimer.stop()
	$Timer.stop()
	self.visible = false

func stopGame():
	restartGame()
	showedTiles	= 0
	self.visible = false
	$GameTimer.stop()
	$Timer.stop()

func setVisible(status):
	self.visible = status

func hackedGame():
	if robot != null:
		get_node(robot).hacked()
func upgradeHackingSpeed(value):
	hackingTime -= value

func upgradeHackingTiles(value):
	tilesShowTime += value

func setTypeOfAttack():
	if attackType == 1:
		attackType = 2
	else:
		attackType = 1

func changeSpeedAtHacking():
	robot.walkingSpeed -= robot.walkingSpeed * changeSpeed

func morePointsPerHacking():
	experiencePointsAfterHacking += int(experiencePointsAfterHacking * morePointsSkills)
	print(experiencePointsAfterHacking)

