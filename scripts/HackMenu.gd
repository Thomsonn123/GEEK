extends Node2D

var Time = 6.0
var progressStep = 10
var curStep = 0

func startHacking():
	$HackingTimer.start()
	var ProgressTimer = Time / 10
	$HackingTimer.wait_time = ProgressTimer
	

func _on_HackingTimer_timeout():
	$ProgressBar.value += 10
	curStep += 1
	if curStep < 10:
		$HackingTimer.start()
	else:
		$Button.queue_free()
		$HackingTimer.queue_free()
		$ProgressBar.queue_free()

	
