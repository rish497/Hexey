extends Node2D
var cursor = preload("res://Assets/New Piskel-5.png (1).png")
func _ready() -> void:
	Global.set_cursor(cursor)
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
