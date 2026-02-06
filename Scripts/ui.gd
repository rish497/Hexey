extends Area2D
@export var min_x: float = -103.0
@export var max_x: float = -35.0
@export var volume_type: String = "ui" 

var dragging: bool = false
var grab_offset: float = 0.0

func _ready() -> void:
	input_pickable = true

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			var mouse_x: float = get_viewport().get_mouse_position().x
			grab_offset = position.x - (mouse_x - get_parent().global_position.x)
		else:
			dragging = false

func _process(_delta: float) -> void:
	if dragging:
		var mouse_x: float = get_viewport().get_mouse_position().x
		var local_mouse_x: float = mouse_x - get_parent().global_position.x
		position.x = clamp(local_mouse_x + grab_offset, min_x, max_x)
		_update_volume()

func _update_volume() -> void:
	var vol: float = clamp(
		inverse_lerp(min_x, max_x, position.x),
		0.0,
		1.0
	)

	match volume_type:
		"master":
			AudioManager.set_master_volume(vol)
		"sfx":
			AudioManager.set_sfx_volume(vol)
		"music":
			AudioManager.set_music_volume(vol)
		"ui":
			AudioManager.set_ui_volume(vol)
