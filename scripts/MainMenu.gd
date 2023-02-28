extends Sprite


func _ready():
	$VideoPlayer/Timer.wait_time = 6
	$VideoPlayer/Timer.start()
	$VideoPlayer.play()

func closeIntro():
	$VideoPlayer.queue_free()

func _on_Game_pressed():
	self.visible = false

func changeVisible():
	$Background.visible = !$Background.visible

func changeCredits():
	$Przypisy.visible = !$Przypisy.visible
	
