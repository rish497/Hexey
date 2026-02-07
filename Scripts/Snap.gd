extends Node2D

@export var locked: bool = false
@onready var collision_polygon: CollisionPolygon2D = $Area2D/CollisionPolygon2D
@onready var collision := $CollisionShape2D

const TILE_SIZE := Vector2(1, 1)
var dragging := false


func _input(event):

	if locked:
		dragging = false
		return

	if Global.position:
		dragging = false
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var local_mouse_pos := collision_polygon.to_local(get_global_mouse_position())
			if point_in_polygon(local_mouse_pos, collision_polygon.polygon):
				dragging = true
				z_index = _get_top_z()
		else:
			dragging = false


func _physics_process(_delta):
	if locked:
		return

	if dragging:
		global_position = get_global_mouse_position().snapped(TILE_SIZE) + TILE_SIZE / 2


func _get_top_z() -> int:
	var max_z := 0
	for n in get_parent().get_children():
		if n is Node2D and n.z_index < Global.player_top_z:
			max_z = max(max_z, n.z_index)
	return max_z + 1


func point_in_polygon(point: Vector2, polygon: PackedVector2Array) -> bool:
	var inside := false
	var j := polygon.size() - 1
	for i in polygon.size():
		if ((polygon[i].y > point.y) != (polygon[j].y > point.y)) and \
		(point.x < (polygon[j].x - polygon[i].x) * (point.y - polygon[i].y) / (polygon[j].y - polygon[i].y) + polygon[i].x):
			inside = not inside
		j = i
	return inside
