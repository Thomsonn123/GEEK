extends Node2D


export var hackingTime = 8
export var tilesShowTime = 1
export var maxTiles = 4
var robot = null

var showedTiles = 0
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
	tileContainer = get_node("Buttons")
	tileContainerChildCount = tileContainer.get_child_count()
	$GameTimer.wait_time = hackingTime

func _physics_process(_delta):
	if showedTiles >= maxTiles:
		stopGame()
	$ProgressBar.value = $GameTimer.time_left

func start():
	self.visible = true
	$Button.visible = true

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
	hackedGame()
	$GameTimer.stop()
	$Timer.stop()
	self.visible = false

func stopGame():
	showedTiles	= 0
	self.visible = false
	$GameTimer.stop()
	$Timer.stop()
	restartGame()
	

func setVisible(status):
	self.visible = status

func hackedGame():
	if robot != null:
		get_node(robot).hacked()
