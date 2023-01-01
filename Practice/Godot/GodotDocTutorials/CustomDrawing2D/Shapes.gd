extends Node2D

export(Texture) var texture setget _set_texture
var rotation_angle = 500
var angle_from = 75
var angle_to = 195

func _set_texture(value):
	texture = value
	update()

func _draw():
	var center = Vector2(200, 200)
	var radius = 80
	var color = Color(1.0, 0.0, 0.0)
	draw_circle_arc(center, radius, angle_from, angle_to, color)

func _process(delta):
	angle_from += rotation_angle * delta
	angle_to += rotation_angle * delta
	
	if angle_from > 360 and angle_to > 360:
		angle_from = wrapf(angle_from, 0, 360)
		angle_to = wrapf(angle_to, 0, 360)
	update()
	
func draw_circle_arc(center, radius, angle_from, angle_to, color) -> void:
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
	
	for i in range(nb_points + 1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
		
#	for index_point in range(nb_points):
#		draw_line(points_arc[index_point], points_arc[index_point + 1], color)
	draw_polygon(points_arc, colors)
