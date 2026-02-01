extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
