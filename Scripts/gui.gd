extends Control

func _on_button_pressed() -> void:
	Global.position = true
	print(Global.position)


func _on_button_2_pressed() -> void:
	Global.position = false
	print(Global.position)
