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
@onready var tutorial: Node2D = $Tutorial
@onready var task_bar: Label = $"."
@onready var menu: Node2D = $Label/Menu
var cursor = preload("uid://cj1fos7c57t58")
func _ready() -> void:
	Global.set_cursor(cursor)
	task_bar.text = Global.profile_name
	WizardAnimation.play("Idle")
	LVLSelect.visible = false
	levels_f_1.visible = false
	wizard.visible = false
	volume.visible = false
	tutorial.visible = false
	menu.visible = false
var wizard_500_done := false
	
func _process(delta: float) -> void:
	if levels_f_1.visible == false:
		open_folder.visible = false
		folder_close.visible = true
	if Global.bit >= 500 and not wizard_500_done:
		wizard_500_done = true
		await get_tree().create_timer(.5).timeout
		wizard_loop()
@onready var email: Node2D = $Email
@onready var error_effect: Node2D = $Email/TextureRect/ErrorEffect
@onready var error_effect_2: Node2D = $Email/TextureRect2/ErrorEffect2
@onready var bubble_2: Sprite2D = $Wizard/Bubble2
@onready var color_rect: ColorRect = $ColorRect
var cursor_2 = preload("uid://cfqdlamyugwt8")
@onready var cia_self_made_logo_: Node2D = $"CIA(SelfMadeLogo)"
@onready var color_rect_2: ColorRect = $ColorRect2

func wizard_loop() -> void:
	Global.set_cursor(cursor_2)
	color_rect.visible = true
	popup(wizard,2)
	bit_500_complete()
	while wizard_500_done:
		await wizard_bit500()
		await get_tree().create_timer(0.2).timeout
@onready var buble_filler: Label = $Wizard/Label
@onready var bubble: Sprite2D = $Wizard/Bubble
@onready var email_notification: Node2D = $"../EmailNotification"
var email_final_pos: Vector2


func emailcomein():
	email_notification.modulate.a = 0.0
	email_final_pos = email_notification.position
	var email_tween: Tween
	if email_tween:
		email_tween.kill()

	email_notification.visible = true
	email_notification.position = email_final_pos + Vector2(400, 0)
	email_notification.modulate.a = 0.0

	email_tween = create_tween()
	email_tween.set_parallel(true)

	email_tween.tween_property(
		email_notification,
		"position",
		email_final_pos,
		0.35
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	email_tween.tween_property(
		email_notification,
		"modulate:a",
		1.0,
		0.2
	)

func bit_500_complete():
	await get_tree().create_timer(2).timeout
	popup(email,0.5)
	await get_tree().create_timer(0.5).timeout
	buble_filler.visible = false
	bubble.visible = false
	move_to(bubble_2,Vector2(-346,-73),1.5)
	await get_tree().create_timer(2).timeout
	fade_out(bubble_2)
	fade_out(error_effect_2)
	await get_tree().create_timer(3).timeout
	move_to(cia_self_made_logo_,Vector2(472,-133),1)
	await get_tree().create_timer(1.5).timeout
	fade_in(color_rect_2,.5)
	await get_tree().create_timer(0.8).timeout
	Global.set_cursor(cursor)
	emailcomein()
	

func wizard_bit500() -> void:
	WizardAnimation.play("Shoot")
	WizardAnimation.flip_h = false
	await get_tree().create_timer(0.3).timeout
	WizardAnimation.flip_h = true
	await get_tree().create_timer(0.3).timeout
	WizardAnimation.flip_h = false
	await get_tree().create_timer(0.3).timeout
	WizardAnimation.flip_h = true
	await get_tree().create_timer(0.3).timeout
	WizardAnimation.play("HalfArmLift")
	await get_tree().create_timer(0.3).timeout
	WizardAnimation.play("ArmLift")
	await get_tree().create_timer(0.3).timeout
	WizardAnimation.play("HalfArmLift")
	await get_tree().create_timer(0.3).timeout
	WizardAnimation.play("ArmLift")

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

	t.tween_property(panel, "scale", Vector2(0.8, 0.8),0.2)
	t.tween_property(panel, "modulate:a", 0.0,0.15)

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
	

@onready var email_2: Node2D = $"../Email2"

func _on_email_notification_pressed() -> void:
	fade_out(email_notification)
	popup(email_2)
	email_notification.position = Vector2(1026,451)
