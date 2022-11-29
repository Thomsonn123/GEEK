extends Node2D


func _physics_process(_delta):
	var isPlaying = $VideoPlayer.is_playing()
	if !isPlaying:
		$VideoPlayer.play()
	
	var isPlaying2 = $VideoPlayer2.is_playing()
	if !isPlaying2:
		$VideoPlayer2.play()
