extends StaticBody2D

export(NodePath) var lightPosition = null

var textureImage = Image.new()
var textureBitmap = BitMap.new()

func _ready():
	textureImage = $Sprite.texture.get_data()
	textureBitmap.create_from_image_alpha(textureImage)
	var rect = Rect2(position.x, position.y, textureImage.get_width(), textureImage.get_height())
	var polygonsArray = textureBitmap.opaque_to_polygons(rect)
	var my_polygon = OccluderPolygon2D.new()
	my_polygon.set_polygon(polygonsArray)
	$LightOccluder2D.occluder = my_polygon

