extends Area2D

var collected = false

func collect():
	collected = true
	$Timer.start()

func timerFinish():
	collected = false