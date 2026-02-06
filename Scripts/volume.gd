extends Node
@onready var volume: Node2D = $"."
@onready var sound_volume_display: Sprite2D = $SoundLabel/SoundVolumeDisplay

@export var min_y: float = -2.0
@export var max_y: float = -19.0 
func _on_button_pressed() -> void:
	hide_popup(self)
	
func hide_popup(panel):
	var t := create_tween()
	t.set_parallel(false)

	t.tween_property(panel, "scale", Vector2(0.8, 0.8), 0.2)
	t.tween_property(panel, "modulate:a", 0.0, 0.15)

	t.tween_callback(func():
		panel.visible = false
		panel.scale = Vector2.ONE
		panel.modulate.a = 1.0)
func _process(_delta: float) -> void:
	_update_display()

func _update_display() -> void:
	var volume: float = AudioManager.master_volume
	sound_volume_display.position.y = lerpf(min_y, max_y, volume)
