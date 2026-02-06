extends Label
@onready var wizard: Node2D = $Wizard
@onready var WizardAnimation: AnimatedSprite2D = $Wizard/Wizard
@onready var LVLSelect: Node2D = $Window
@onready var levels_f_1: Node2D = $LevelsF1
@onready var folder_close: Label = $Window/F1/FolderClose
@onready var open_folder: Label = $Window/F1/OpenFolder
@onready var folder_close_F2: Label = $Window/F2/FolderClose
@onready var open_folder_F2: Label = $Window/F2/OpenFolder
@onready var volume: Node2D = $Volume


func _ready() -> void:
	WizardAnimation.play("Idle")
	LVLSelect.visible = false
	levels_f_1.visible = false
	wizard.visible = false

func _on_f_2_pressed() -> void:
	if open_folder_F2.visible == true:
		open_folder_F2.visible = false
		folder_close_F2.visible = true
	elif folder_close_F2.visible == true:
		folder_close_F2.visible = false
		open_folder_F2.visible = true


func _on_f_1_pressed() -> void:
	if open_folder.visible == true:
		open_folder.visible = false
		folder_close.visible = true
		
		fade_out(levels_f_1)
	elif folder_close.visible == true:
		folder_close.visible = false
		open_folder.visible = true
		popup(levels_f_1,.6)

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

	t.tween_property(panel, "scale", Vector2(0.8, 0.8), 0.2)
	t.tween_property(panel, "modulate:a", 0.0, 0.15)

	t.tween_callback(func():
		panel.visible = false
		panel.scale = Vector2.ONE
		panel.modulate.a = 1.0
	)

func _on_button_pressed() -> void:
	popup(LVLSelect)


func _on_button_4_pressed() -> void:
	popup(wizard)


func _on_button_3_pressed() -> void:
	pass


func _on_button_5_pressed() -> void:
	popup(volume)
