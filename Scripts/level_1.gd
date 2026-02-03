extends Node2D

func _ready() -> void:
	Global.level_amount=1

func _process(delta: float) -> void:
	if Global.folder_collected == Global.level_amount:
		Global.level_pass = true

func _on_button_pressed() -> void:
	Global.position = true
	print(Global.position)


func _on_button_2_pressed() -> void:
	Global.position = false
	print(Global.position)
