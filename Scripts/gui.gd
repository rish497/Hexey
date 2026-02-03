extends Control
func _on_button_pressed() -> void:
	print("working")
	Global.position = true
	print(Global.position)


func _on_button_2_pressed() -> void:
	print("working")
	get_tree().reload_current_scene()
	Global.position = false
	print(Global.position)
