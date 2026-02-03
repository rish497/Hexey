extends Node
var position = false
var level_pass=false
var level_amount
var folder_collected = 0
var total_folder_collected = 0
var last_position_state := false
var max_z
var player_top_z := 100000

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if level_pass == true:
		print("You did it")
		return

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
	
