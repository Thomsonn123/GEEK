extends StaticBody2D

export(NodePath) var light
export var shadow_start_color = Color.black
export var shadow_end_color = Color(0, 0, 0, 0)
var localLight
func _ready():
	if localLight == null:
		localLight = get_node(light)

func _physics_process(_delta):
	$Shadow.look_at(localLight.global_position)

	

