extends Label
@onready var wizard: Node2D = $Wizard
@onready var WizardAnimation: AnimatedSprite2D = $Wizard/Wizard
@onready var volume: Node2D = $Volume
@onready var tutorial: Node2D = $Tutorial
@onready var task_bar: Label = $"."
@onready var menu: Node2D = $Label/Menu


func _ready() -> void:
	task_bar.text = Global.profile_name
	WizardAnimation.play("Idle")
	wizard.visible = false
	volume.visible = false
	tutorial.visible = false
	menu.visible = false
	
func popup(panel, dur := .5):
	panel.visible = true
	panel.scale = Vector2(-.5,-.5)
	panel.modulate.a = 0.0

	var t := create_tween()
	t.set_parallel(true)
	t.tween_property(panel,"scale",Vector2.ONE,dur).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	t.tween_property(panel,"modulate:a",1.0,dur)
	
func fade_in(panel,dur):
	panel.visible = true
	panel.modulate.a = 0.0
	var t := create_tween()
	t.tween_property(panel,"modulate:a",1.0,dur)
	
func fade_out(panel, duration := 0.5):
	var t := create_tween()
	t.tween_property(
		panel,
		"modulate:a",
		0.0,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func hide_popup(panel):
	var t := create_tween()
	t.set_parallel(false)

	t.tween_property(panel, "scale", Vector2(0.8, 0.8),0.2)
	t.tween_property(panel, "modulate:a", 0.0,0.15)

	t.tween_callback(func():
		panel.visible = false
		panel.scale = Vector2.ONE
		panel.modulate.a = 1.0
	)
func _on_button_4_pressed() -> void:
	popup(wizard)



func _on_button_3_pressed() -> void:
	popup(tutorial)


func _on_button_5_pressed() -> void:
	popup(volume)


func _on_button_2_pressed() -> void:
	if menu.visible == false:
		move_to(menu,Vector2(2.0,-323.0))
	elif menu.visible == true:
		move_to(menu,Vector2(2.0,-271.0))
		await get_tree().create_timer(0.4).timeout
		menu.visible = false
		
func move_to(panel, target_pos: Vector2, duration := .7):
	panel.visible = true
	var t := create_tween()
	t.tween_property(
		panel,
		"position",
		target_pos,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
