extends Node2D
@export var label_text := "LVL SELECT"
@onready var label: Label = $NinePatchRect/Label
@onready var window: Node2D = $"."
@onready var texture_rect: TextureRect = $TextureRect
func _on_button_pressed() -> void:
	Global.clicksound()
	print("close")
	hide_popup(window)

func hide_popup(panel):
	var t := create_tween()
	t.set_parallel(false)

	t.tween_property(panel, "scale", Vector2(0.8, 0.8), 0.2)
	t.tween_property(panel, "modulate:a", 0.0, 0.15)

	t.tween_callback(func():
		panel.visible = false
		panel.scale = Vector2.ONE
		panel.modulate.a = 1.0
	)
