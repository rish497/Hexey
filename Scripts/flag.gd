extends CharacterBody2D

signal position_ready(pos: Vector2)

func _ready():
	add_to_group("flag_group")

func _process(_delta):
	position_ready.emit(global_position)
	visible = not Global.level_pass
