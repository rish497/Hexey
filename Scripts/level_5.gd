extends Node2D
var cursor = preload("res://Assets/New Piskel-5.png (1).png")
var bitgiven = false
func _ready() -> void:
	Global.set_cursor(cursor)
	Global.level_amount=4
	Global.folder_collected = 0
	Global.level_pass = false
	
func _process(delta: float) -> void:
	if Global.folder_collected == Global.level_amount and bitgiven==false:
		Global.level_pass = true
		Global.F1_level5_pass = true
		Global.last_completed_level = 5
		bitgiven = true
