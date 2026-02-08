extends Node
var position = false
var level_amount
var folder_collected = 0
var total_folder_collected = 0
var last_position_state := false
var max_z
var player_top_z := 100000
var profile_name: String
var email_animation_played := false
var goal := 500
var custom_cursor = preload("res://Assets/New Piskel-5.png (1).png")
var hand_cursor = preload("res://Assets/New Piskel-5.png (1).png")
var F1_level1_display = true
var F1_level2_display = true
var F1_level3_display = true
var F1_level4_display = true
var F1_level5_display = true
var F1_level6_display = true
var last_completed_level := 0
var F1_level1_pass=false
var F1_level2_pass=false
var F1_level3_pass=false
var F1_level4_pass=false
var F1_level5_pass=false
var F1_level6_pass=false
var level_pass = false
var bit := 0
		
func set_cursor(cursor):
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW) 
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_POINTING_HAND)

func set_hex_covered(hex_sprite: Sprite2D, covered: bool, top_height: int, full_height: int) -> void:
	if not hex_sprite or not hex_sprite.texture:
		return

	hex_sprite.region_enabled = true

	if covered:
		# Show only the green top
		hex_sprite.region_rect = Rect2(
			Vector2(0, 0),
			Vector2(hex_sprite.texture.get_width(), top_height)
		)
	else:
		# Show full sprite
		hex_sprite.region_rect = Rect2(
			Vector2.ZERO,
			Vector2(hex_sprite.texture.get_width(), full_height)
		)
	
