extends Node2D

@onready var area: Area2D = $Area2D

var dragging := false
var offset := Vector2.ZERO

func _ready():
	area.input_pickable = true
	set_process_unhandled_input(true)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if is_mouse_on_area():
				dragging = true
				offset = global_position - get_global_mouse_position()
				get_viewport().set_input_as_handled()
		else:
			dragging = false

	elif event is InputEventMouseMotion and dragging:
		global_position = get_global_mouse_position() + offset

func is_mouse_on_area() -> bool:
	var space := get_world_2d().direct_space_state
	var query := PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	query.collide_with_areas = true
	query.collision_mask = area.collision_mask

	var result = space.intersect_point(query)
	for hit in result:
		if hit.collider == area:
			return true
	return false
