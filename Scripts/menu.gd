extends Node2D

func _on_close_lvl_button_pressed() -> void:
	Transition.change_scene(self,"The2ndMainPage")
