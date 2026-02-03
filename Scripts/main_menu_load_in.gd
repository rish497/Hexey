extends Control

@onready var label_1: Label = $VBoxContainer/Label
@onready var label_2: Label = $VBoxContainer/Label2
@onready var label_3: Label = $VBoxContainer/Label3
@onready var color_rect: ColorRect = $ColorRect
@onready var typing_sound: AudioStreamPlayer =	$TypeSound

var typing_speed := 0.04

var generator := AudioStreamGenerator.new()
var playback: AudioStreamGeneratorPlayback
var phase := 0.0

func _ready() -> void:
	color_rect.modulate.a = 1.0
	generator.mix_rate = 44100
	generator.buffer_length = 0.1
	typing_sound.stream = generator
	typing_sound.play()
	playback = typing_sound.get_stream_playback()

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
	await get_tree().create_timer(2.2).timeout




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
