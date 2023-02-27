extends Sprite

var player
var destination
var sound

func init(position, positionTo, path, value):
	self.position = position
	destination = positionTo
	sound = path
	$Audio.volume_db = value

func _physics_process(delta):
	if destination != null:
		self.position = position.move_toward(destination, delta * 100)
	if self.position == destination and !$Audio.playing:
		self.visible = false
		playSound(sound)

func bodyIn(body:Node):
	if "Robot" in body.name:
		body.attackedByPlayer()
		playSound(sound)
	
func playSound(soundToPlay):
	$Audio.stream = soundToPlay
	$Audio/Timer.wait_time = $Audio.stream.get_length()
	$Audio/Timer.start()
	$Audio.play()

func soundFinished():
	$Audio/Timer.stop()
	$Audio.stop()
	self.queue_free()
