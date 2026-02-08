extends Control
@onready var F2_Blocker: TextureRect = $Window/TextureRect
@onready var errors: Node2D = $errors
@onready var email_notification: Node2D = $EmailNotification
@onready var window: Node2D = $Window
var email_final_pos: Vector2
@onready var email: Node2D = $Email
@onready var CIA: Node2D = $"CIA(SelfMadeLogo)"
@onready var error_effect: Node2D = $Email/TextureRect/ErrorEffect
@onready var error_effect_2: Node2D = $Email/TextureRect2/ErrorEffect2
@onready var error_effect_3: Node2D = $ErrorEffect3
@onready var error_effect_4: Node2D = $ErrorEffect4
@onready var error_effect_5: Node2D = $ErrorEffect5
@onready var error_effect_6: Node2D = $ErrorEffect6
@onready var error_effect_7: Node2D = $ErrorEffect7
@onready var texture_rect: TextureRect = $Email/TextureRect
@onready var texture_rect_2: TextureRect = $Email/TextureRect2
@onready var folder_close: Label = $Window/F1/FolderClose
@onready var open_folder: Label = $Window/F1/OpenFolder
@onready var folder_close_F2: Label = $Window/F2/FolderClose
@onready var open_folder_F2: Label = $Window/F2/OpenFolder
@onready var wizard: AnimatedSprite2D = $Wizard/Wizard
@onready var WizardWindow: Node2D = $Wizard
@onready var shield: Sprite2D = $Shield
@onready var bubble_filler: Sprite2D = $"Wizard/Label/Bubble Filler"
@onready var bubble: Sprite2D = $Wizard/Bubble
@onready var bubble_filler_container: Label = $Wizard/Label
@onready var f_1: Button = $Window/F1
@onready var levels_f_1: Node2D = $LevelsF1
@onready var bubble_2: Sprite2D = $Wizard/Bubble2
var cursor = preload("res://Assets/New Piskel-6.png (3).png")
var cursor1 = preload("res://Assets/New Piskel-5.png (1).png")
func _ready():
	Global.set_cursor(cursor1)
	bubble_2.visible = false
	folder_close.visible = true
	open_folder.visible = false
	folder_close_F2.visible = true
	open_folder_F2.visible = false
	if Global.email_animation_played:
		bubble.visible = false
		bubble_filler.visible = false
		errors.visible = true
		email_notification.visible = true
		email_notification.position = email_final_pos
		email_notification.modulate.a = 1.0
		return

	Global.email_animation_played = true
	reset_state()
	start_sequence()

func reset_state():
	bubble.visible = false
	bubble_filler.visible = false
	WizardWindow.visible = false
	email.visible = false
	window.visible = false
	errors.visible = false
	email_notification.visible = false
	email_notification.modulate.a = 0.0


func start_sequence() -> void:
	Global.aliensound()
	errors.visible = true
	await get_tree().create_timer(1.0).timeout
	emailcomein()
	await get_tree().create_timer(.4).timeout

	move_to(CIA, Vector2(369,472), 0.4)
	await get_tree().create_timer(1.2).timeout
	move_to(CIA, Vector2(444,594), 0.4)
func emailcomein():
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


func _on_email_notification_pressed() -> void:
	Global.clicksound()
	Global.set_cursor(cursor)
	fade_out(email_notification, .5)
	email_notification.position = Vector2(1075,391)
	popup(email)
	await get_tree().create_timer(2.3).timeout
	move_to(CIA, Vector2(284,240), .5)
	await get_tree().create_timer(.5).timeout
	Global.throwsound()
	move_node_in_arc(error_effect,Vector2(-289,30),error_effect.position,150,1)
	await get_tree().create_timer(1).timeout
	Global.throwsound()
	move_node_in_arc(error_effect_2,Vector2(-289,30),error_effect_2.position,160, 1)
	await get_tree().create_timer(2).timeout
	move_to(texture_rect, Vector2(-716,154), 1)
	await get_tree().create_timer(.6).timeout
	move_to(texture_rect_2, Vector2(-716,154), 1)
	await get_tree().create_timer(.4).timeout
	Global.tpsound()
	spin_and_shrink(texture_rect, TAU, 0.0, 1)
	await get_tree().create_timer(.6).timeout
	Global.tpsound()
	spin_and_shrink(texture_rect_2, TAU, 0, 1)
	await get_tree().create_timer(1.4).timeout
	hide_popup(email)
	move_node_in_arc(CIA, CIA.position, Vector2(700,130), 130, .7)
	await get_tree().create_timer(1).timeout
	popup(window)
	Global.clicksound()
	Global.throwsound()
	move_node_in_arc(error_effect_3,Vector2(700,130),Vector2(233,229),160, 1)
	await  get_tree().create_timer(2).timeout
	popup(WizardWindow)
	Global.clicksound()
	wizard.play("Idle")
	fade_out(error_effect_3)
	F2_Blocker.visible = true
	
	await get_tree().create_timer(1.4).timeout
	wizard.play("HalfArmLift")
	await get_tree().create_timer(.2).timeout
	wizard.play("ArmLift")
	fade_in(shield, 2)
	Global.shieldsound()
	await get_tree().create_timer(2.5).timeout
	wizard.play("Idle")
	error_effect_4.visible = true
	Global.throwsound()
	move_node_in_arc(error_effect_4, Vector2(700,130), Vector2(131,227),160,1)
	await  get_tree().create_timer(2).timeout
	fade_out(error_effect_4)
	Global.buildup()
	await get_tree().create_timer(1).timeout
	spin_and_shrink(CIA, 2*TAU, 0.0, 1.2)
	await get_tree().create_timer(1.4).timeout
	error_effect_4.visible = true
	error_effect_3.visible = true
	move_node_in_arc(error_effect_3,Vector2(700,130),error_effect_3.position,160, .7)
	move_node_in_arc(error_effect_4,Vector2(700,130),error_effect_4.position,160, .7)
	move_node_in_arc(error_effect_5,Vector2(700,130),error_effect_5.position,160, .7)
	move_node_in_arc(error_effect_6,Vector2(700,130),error_effect_6.position,160, .7)
	move_node_in_arc(error_effect_7,Vector2(700,130),error_effect_7.position,160, .7)	
	await get_tree().create_timer(.4).timeout
	fade_out(shield, .5)
	wizard.play("HalfArmLift")
	await get_tree().create_timer(.2).timeout
	wizard.play("ArmLift")
	bubble_fill(12,1.5)
	await get_tree().create_timer(2).timeout
	_on_button_pressed()
	await get_tree().create_timer(.5).timeout
	wizard.play("Shoot")
	bubble.visible = false
	bubble_filler_container.visible = false
	bubble_2.visible = true
	move_to(bubble_2,Vector2(332,4),2)
	await get_tree().create_timer(2.3).timeout
	spin_and_shrink(bubble_2,TAU,0,0.7)
	await get_tree().create_timer(1.2).timeout
	Global.explosionsound()
	Transition.change_scene(self,"level_1")
	Global.email_animation_played = true
	Global.aliensoundstop()
	
func bubble_fill(end_y: float, dur: float) -> void:
	bubble.visible = true
	bubble_filler.visible = true
	var start_y := bubble_filler.position.y
	fade_in(bubble, 0.5)
	var t := create_tween()
	t.tween_property(bubble_filler,"position:y",end_y,dur).set_trans(Tween.TRANS_LINEAR)
		
func popup(panel, dur := .4):
	panel.visible = true
	panel.scale = Vector2(-.2,-.2)
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

func move_to(panel, target_pos: Vector2, duration := 0.4):
	var t := create_tween()
	t.tween_property(
		panel,
		"position",
		target_pos,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func move_node_in_arc(
	node: Node,
	start: Vector2,
	end: Vector2,
	height := 100.0,
	duration := 0.5
) -> void:
	node.visible = true
	var control := (start + end) * 0.5 + Vector2(0, -height)

	var t := node.create_tween()
	t.tween_method(
		func(p):
			if node is Control:
				node.position = bezier(start, control, end, p)
			elif node is Node2D:
				node.position = bezier(start, control, end, p),
		0.0,
		1.0,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func bezier(a: Vector2, b: Vector2, c: Vector2, t: float) -> Vector2:
	return a.lerp(b, t).lerp(b.lerp(c, t), t)
	
func spin_and_shrink(node: Node,rotation_amount := TAU,end_scale := 0.0,duration := 0.7) -> void:
	var t := node.create_tween()
	t.set_parallel(true)
	t.tween_property(node,"rotation",node.rotation + rotation_amount,duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	t.tween_property(node,"scale",Vector2.ONE * end_scale,duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)

	
func _on_button_pressed() -> void:
	if open_folder.visible == true:
		open_folder.visible = false
		folder_close.visible = true
		fade_out(levels_f_1)
	elif folder_close.visible == true:
		folder_close.visible = false
		open_folder.visible = true
		popup(levels_f_1,.6)


func _on_f_2_pressed() -> void:
	if open_folder_F2.visible == true:
		open_folder_F2.visible = false
		folder_close_F2.visible = true
	elif folder_close_F2.visible == true:
		folder_close_F2.visible = false
		open_folder_F2.visible = true
	
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
