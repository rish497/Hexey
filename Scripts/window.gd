extends Node2D
@export var label_text := "LVL SELECT"
@onready var label: Label = $NinePatchRect/Label
@onready var window: Node2D = $"."
@onready var texture_rect: TextureRect = $TextureRect

var dragging = false
var of = Vector2(0,0)

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position() - of
		


func _ready() -> void:
	label.text = label_text


func _on_button_pressed() -> void:
	hide_popup(window)

func hide_popup(panel):
	var t := create_tween()
	t.set_parallel(true)
	t.tween_property(panel,"scale",Vector2(0.8, 0.8),0.2)
	t.tween_property(panel,"modulate:a",0,0.15)
	t.tween_callback(func():panel.visible = false)


func _on_button_2_button_down() -> void:
	dragging = true
	of = get_global_mouse_position()-global_position


func _on_button_2_button_up() -> void:
		dragging = false
