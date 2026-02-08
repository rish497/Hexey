extends Control
var typing_speed := 0.04

var generator := AudioStreamGenerator.new()
var playback: AudioStreamGeneratorPlayback
var phase := 0.0
@onready var label: Label = $ColorRect/Label
var cursor = preload("res://Assets/New Piskel-5.png (1).png")
@onready var type_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	Global.set_cursor(cursor)
	generator.mix_rate = 44100
	type_player.stream = generator
	type_player.play()
	playback = type_player.get_stream_playback()

func _on_button_6_pressed() -> void:
	print("working")
	Global.position = true
	print(Global.position)


func _on_button_7_pressed() -> void:
	print("working")
	get_tree().reload_current_scene()
	Global.folder_collected = 0
	Global.position = false
	print(Global.position)

@onready var color_rect: ColorRect = $ColorRect
@onready var label_2: Label = $ColorRect/Label2
@onready var label_3: Label = $ColorRect/Label3
@onready var label_4: Label = $ColorRect/Label4
@onready var label_5: Label = $ColorRect/Label5
@onready var label_6: Label = $ColorRect/Label6
@onready var __100_bits: Label = $"ColorRect/+100 Bits"

func _on_portal_body_entered(body: Node2D) -> void:
	if Global.F1_level1_pass == true and Global.F1_level1_display==true:
		fade_in(color_rect, 1)
		await get_tree().create_timer(1).timeout
		await typewriter(label)
		fade_in(__100_bits,.5)
		move_to(__100_bits,Vector2(362,281),.5)
		await get_tree().create_timer(.9).timeout
		Transition.change_scene(self,"The2ndMainPage")
		Global.F1_level1_display= false
		Global.position = false
		
	elif Global.F1_level2_pass == true and Global.F1_level2_display==true:
		fade_in(color_rect, 1)
		await get_tree().create_timer(1).timeout
		await typewriter(label_2)
		fade_in(__100_bits,.5)
		move_to(__100_bits,Vector2(362,281),.5)
		await get_tree().create_timer(.9).timeout

		Global.position = false
		Transition.change_scene(self,"The2ndMainPage")
	elif Global.F1_level3_pass == true and Global.F1_level3_display==true:
		fade_in(color_rect, 1)
		await get_tree().create_timer(1).timeout
		await typewriter(label_3)
		fade_in(__100_bits,.5)
		move_to(__100_bits,Vector2(362,281),.5)
		await get_tree().create_timer(.9).timeout
		Global.position = false
		Transition.change_scene(self,"The2ndMainPage")
		Global.F1_level3_display= false
	elif Global.F1_level4_pass == true and Global.F1_level4_display==true:
		fade_in(color_rect, 1)
		await get_tree().create_timer(1).timeout
		await typewriter(label_4)
		fade_in(__100_bits,.5)
		move_to(__100_bits,Vector2(362,281),.5)
		await get_tree().create_timer(.9).timeout
		Global.position = false
		Transition.change_scene(self,"The2ndMainPage")
		Global.F1_level4_display= false
	elif Global.F1_level5_pass == true and Global.F1_level5_display==true:
		fade_in(color_rect, 1)
		await get_tree().create_timer(1).timeout
		await typewriter(label_5)
		fade_in(__100_bits,.5)
		move_to(__100_bits,Vector2(362,281),.5)
		await get_tree().create_timer(.9).timeout
		Global.position = false
		Transition.change_scene(self,"The2ndMainPage")
		Global.F1_level5_display= false
	elif Global.F1_level6_pass == true and Global.F1_level6_display==true:
		fade_in(color_rect, 1)
		await get_tree().create_timer(1).timeout
		await typewriter(label_6)
		fade_in(__100_bits,.5)
		move_to(__100_bits,Vector2(362,281),.5)
		await get_tree().create_timer(.9).timeout
		Global.position = false
		Transition.change_scene(self,"The2ndMainPage")
		Global.F1_level6_display= false
	

		
func move_to(panel, target_pos: Vector2, duration := .7):
	panel.visible = true
	var t := create_tween()
	t.tween_property(
		panel,
		"position",
		target_pos,
		duration
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
func typewriter(label: Label) -> void:
	label.visible = true
	var full_text := label.text
	label.text = ""

	for char in full_text:
		label.text += char
		play_typing_sound()
		await get_tree().create_timer(typing_speed).timeout
func play_typing_sound():
	if playback == null:
		return

	if playback.get_frames_available() < 200:
		return

	var frequency := 500.0
	var length := 150

	for i in length:
		var sample := sin(phase * TAU) * 0.25
		phase += frequency / generator.mix_rate
		playback.push_frame(Vector2(sample, sample))

func fade_in(panel,dur):
	panel.visible = true
	panel.modulate.a = 0.0
	var t := create_tween()
	t.tween_property(panel,"modulate:a",1.0,dur)
