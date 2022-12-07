extends Node2D

var Time = 2
var progressStep = 10
var curStep = 0

func startHacking():
	$HacingTimer.start()
	var ProgressTimer = Time / 100
	$HacingTimer.wait_time = ProgressTimer
	

func update():
	$ProgressBar.value = 10 * curStep

func _on_HacingTimer_timeout():
	curStep += 1
	update()

	