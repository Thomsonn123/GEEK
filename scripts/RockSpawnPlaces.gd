extends Node2D

var maxRocks = 20
var actualRocks = 0

export(NodePath) var Place1
var rng = RandomNumberGenerator.new()

func spawnRock():
	var place = get_node(Place1)
	var poolint = place.polygon.triangulate_polygon(place.polygon)
	rng.randomize()
	var number = rng.randf_range(0,poolint.size)
	print("triangle: ", poolint[number])

func _process(_delta):
	if actualRocks < maxRocks:
		spawnRock()
