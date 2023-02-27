extends Sprite

var player
var destination
var sound
var speed

func init(position, positionTo, path, value, playerSpeed):
	self.position = position
	destination = positionTo
	sound = path
	$Audio.volume_db = value
	speed = playerSpeed + 300

func _physics_process(delta):
	if destination != null:
		self.position = position.move_toward(destination, delta * speed)
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
