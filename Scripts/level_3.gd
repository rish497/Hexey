extends Node2D
var cursor = preload("res://Assets/New Piskel-5.png (1).png")
var bitgiven = false
func _ready() -> void:
	Global.set_cursor(cursor)
	Global.level_amount=3
	Global.folder_collected = 0
	Global.level_pass = false
	
func _process(delta: float) -> void:
	if Global.folder_collected == Global.level_amount and bitgiven==false:
		Global.level_pass = true
		Global.F1_level3_pass = true
		Global.last_completed_level = 3
		Global.bit +=100
		bitgiven = true
