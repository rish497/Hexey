extends Node2D


func _on_shut_off_button_pressed() -> void:
	Global.clicksound()
	Transition.change_scene(self,"MainMenuLoadIn")
	


func _on_close_lvl_button_pressed() -> void:
	Global.clicksound()
	Transition.change_scene(self,"The2ndMainPage")
