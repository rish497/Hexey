extends Control

@onready var label_1: Label = $VBoxContainer/Label
@onready var label_2: Label = $VBoxContainer/Label2
@onready var label_3: Label = $VBoxContainer/Label3
@onready var color_rect: ColorRect = $ColorRect
@onready var typing_sound: AudioStreamPlayer =	$TypeSound
@onready var h: Node2D = $H2
@onready var e: Node2D = $E3
@onready var x: Node2D = $X2
@onready var e_2: Node2D = $E4
@onready var y: Node2D = $Y2
@onready var button: Button = $Button
var button_target_y: float


var typing_speed := 0.04

var generator := AudioStreamGenerator.new()
var playback: AudioStreamGeneratorPlayback
var phase := 0.0
func animate_button_in() -> void:
	button.visible = true
	button_target_y = button.position.y
	button.position.y += 300

	var t := create_tween()
	t.tween_property(
		button,
		"position:y",
		button_target_y,
		0.45
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _ready() -> void:
	button.visible = false
	color_rect.modulate.a = 1.0
	generator.mix_rate = 44100
	generator.buffer_length = 0.1
	typing_sound.stream = generator
	typing_sound.play()
	playback = typing_sound.get_stream_playback()
	
	for n in [h, e, x, e_2, y]:
		n.scale = Vector2.ZERO
		n.modulate.a = 0.0

	label_1.visible = true
	label_2.visible = false
	label_3.visible = false

	typewriter(label_1)
	await get_tree().create_timer(2).timeout
	label_2.visible = true
	typewriter(label_2)
	await get_tree().create_timer(2).timeout
	label_3.visible = true
	typewriter(label_3)
	await get_tree().create_timer(2.8).timeout

	fade_out_color_rect(1.2)
	label_1.visible = false
	label_2.visible = false
	label_3.visible = false
	
	await animate_letters()
	await get_tree().create_timer(.8).timeout
	animate_button_in()

func animate_letters() -> void:
	for n in [e_2, e, y, h, x]:
		var t := create_tween()
		t.tween_property(n, "modulate:a", 1.0, 0.2)
		t.tween_property(n, "scale", Vector2.ONE, 0.35)\
			.set_trans(Tween.TRANS_BACK)\
			.set_ease(Tween.EASE_OUT)
		await t.finished




func typewriter(label: Label) -> void:
	var full_text := label.text
	label.text = ""

	for char in full_text:
		label.text += char
		play_typing_sound()
		await get_tree().create_timer(typing_speed).timeout

func play_typing_sound():
	if playback.get_frames_available() < 200:
		return

	var frequency := 500.0  
	var length := 150       

	for i in length:
		var sample := sin(phase * TAU) * 0.25
		phase += frequency / generator.mix_rate
		playback.push_frame(Vector2(sample, sample))
		
func fade_out_color_rect(duration := 2.0) -> void:
	var tween := create_tween()
	tween.tween_property(
		color_rect,
		"modulate:a",
		0.0,
		duration
	)
func _on_button_pressed() -> void:
	var letters := [h, e, x, e_2, y]

	var letter_start_y := h.position.y
	var button_start_y := button.position.y

	var meet_offset := 10
	var separate_offset := 360

	var t := create_tween()
	t.set_parallel(true)

	for n in letters:
		t.tween_property(
			n,
			"position:y",
			letter_start_y + meet_offset,
			.3
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	t.tween_property(
		button,
		"position:y",
		button_start_y - meet_offset,
		.3
	).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	await t.finished

	var t2 := create_tween()
	t2.set_parallel(true)

	for n in letters:
		t2.tween_property(
			n,
			"position:y",
			letter_start_y - separate_offset,
			1.10
		).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	t2.tween_property(
		button,
		"position:y",
		button_start_y + separate_offset,
		1.10
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
