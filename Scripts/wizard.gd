extends Node2D

@onready var bubble_filler: Sprite2D = $"Label/Bubble Filler"
@onready var wizard: Node2D = $"."

var starting_pos := Vector2(16, 46)
var final_pos := Vector2(16, 12)
var was_visible := false
@onready var label_2: Label = $NinePatchRect2/Label2

func _on_button_pressed() -> void:
	Global.clicksound()
	print("close")
	hide_popup(wizard)

func _process(_delta: float) -> void:
	label_2.text = str(Global.bit) + " / 500"
	if wizard.visible and not was_visible:
		was_visible = true
		await get_tree().create_timer(.5).timeout
		bubble_fill()
	elif not wizard.visible:
		was_visible = false
		
func bubble_fill():
	var bit: int = Global.bit
	var goal: int = max(Global.goal, 1)
	var progress: float = clamp(float(bit) / float(goal), 0.0, 1.0)
	var target_pos: Vector2 = starting_pos.lerp(final_pos, progress)
	bubble_filler.position = starting_pos
	var t := create_tween()
	t.tween_property(bubble_filler,"position",target_pos,0.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func hide_popup(panel):
	var t := create_tween()
	t.set_parallel(false)

	t.tween_property(panel, "scale", Vector2(0.8, 0.8), 0.2)
	t.tween_property(panel, "modulate:a", 0.0, 0.15)

	t.tween_callback(func():
		panel.visible = false
		panel.scale = Vector2.ONE
		panel.modulate.a = 1.0)

	
