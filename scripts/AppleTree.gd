extends StaticBody2D

var applesPath = "Apples/"
var applesCount
var visibleTurnedOff = []
var rng
export(NodePath) var Player

func _ready():
	applesCount = get_node("Apples").get_child_count()
	rng = RandomNumberGenerator.new()

func collect():
	rng.randomize()
	var i = rng.randi_range(1, applesCount)
	if i in visibleTurnedOff:
		if visibleTurnedOff.size() < applesCount:
			collect()
		elif !$CollectTimer.is_stopped():
			$CollectTimer.stop()
	else:
		get_node(applesPath + str(i)).visible = false
		visibleTurnedOff.append(i)
		get_node(applesPath + str(i) + "/Timer").start()
		print("Collect ", i)
		get_node(Player).add("Apple")

func collectAll():
	$CollectTimer.start()

func unCollectApple(value):
	print("unCollect ", value)
	if value in visibleTurnedOff:
		visibleTurnedOff.erase(value)
		get_node(applesPath + str(value) + "/Timer").stop()
		get_node(applesPath + str(value)).visible = true

func playerEnter(body:Node):
	if body.name == "Player":
		if body.treeAutocollect == true:
			collectAll()
		else:
			body.entity = self.get_path()

func playerExit(body:Node):
	if body.name == "Player":
		body.entity = null
