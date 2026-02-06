extends Node2D
@onready var levels_f_1: Node2D = $"."

func _on_button_pressed() -> void:
	print("close")
	hide_popup(levels_f_1)

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
