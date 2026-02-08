extends Node2D

func _on_shut_off_button_pressed() -> void:
		Transition.change_scene(self,"MainMenuLoadIn")
