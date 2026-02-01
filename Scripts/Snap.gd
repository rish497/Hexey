extends Node2D

@onready var collision_polygon: CollisionPolygon2D = $Area2D/CollisionPolygon2D

const TILE_SIZE: Vector2 = Vector2(1, 1)
var dragging := false

func point_in_polygon(point: Vector2, polygon: PackedVector2Array) -> bool:
	var inside := false
	var j := polygon.size() - 1
	for i in polygon.size():
		if ((polygon[i].y > point.y) != (polygon[j].y > point.y)) and \
			(point.x < (polygon[j].x - polygon[i].x) * (point.y - polygon[i].y) / (polygon[j].y - polygon[i].y) + polygon[i].x):
			inside = not inside
		j = i
	return inside

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var local_mouse_pos = collision_polygon.to_local(get_global_mouse_position())
			if point_in_polygon(local_mouse_pos, collision_polygon.polygon):
				dragging = true
				var parent_nodes = get_parent().get_children()
				var max_z := 0
				for n in parent_nodes:
					if n is Node2D:
						max_z = max(max_z, n.z_index)
				z_index = max_z + 1
		else:
			dragging = false

func _physics_process(delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position().snapped(TILE_SIZE) + TILE_SIZE / 2


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.name == "ChracterBody2D":
		print("success")
