extends Control

var typing_speed := 0.04
var sequence_running := false

var generator := AudioStreamGenerator.new()
var playback: AudioStreamGeneratorPlayback
var phase := 0.0

@onready var type_player: AudioStreamPlayer = $AudioStreamPlayer

@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $ColorRect/Label
@onready var label_2: Label = $ColorRect/Label2
@onready var label_3: Label = $ColorRect/Label3
@onready var label_4: Label = $ColorRect/Label4
@onready var label_5: Label = $ColorRect/Label5
@onready var label_6: Label = $ColorRect/Label6
@onready var __100_bits: Label = $"ColorRect/+100 Bits"

var cursor = preload("res://Assets/New Piskel-5.png (1).png")

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
	Global.level_pass = false
	Global.Display_level = false
	Global.position = false

	print(Global.position)

func _process(_delta: float) -> void:
	if sequence_running:
		return

	if not Global.Display_level:
		return
	if Global.Display_level == true:
			
		match Global.last_completed_level:
			1:
				start_sequence(label)
				Global.Display_level = false
			2:
				start_sequence(label_2)
				Global.Display_level = false
			3:
				start_sequence(label_3)
				Global.Display_level = false
			4:
				start_sequence(label_4)
				Global.Display_level = false
			5:
				start_sequence(label_5)
				Global.Display_level = false
			6:
				start_sequence(label_6)
				Global.Display_level = false
			_:
				return

	Global.Display_level = false
	Global.last_completed_level = 0

func start_sequence(target_label: Label) -> void:
	sequence_running = true
	run_sequence(target_label)

func run_sequence(target_label: Label) -> void:
	fade_in(color_rect, 1.0)
	await get_tree().create_timer(1.0).timeout

	await typewriter(target_label)

	fade_in(__100_bits, 0.5)
	Global.money()
	move_to(__100_bits, Vector2(362, 281), 0.5)
	await get_tree().create_timer(0.9).timeout

	Global.Display_level = false
	Global.position = false

	Transition.change_scene(self, "The2ndMainPage")

func move_to(panel, target_pos: Vector2, duration := 0.7):
	panel.visible = true
	var t := create_tween()
	t.tween_property(panel, "position", target_pos, duration)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)

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

func fade_in(panel, dur):
	panel.visible = true
	panel.modulate.a = 0.0
	var t := create_tween()
	t.tween_property(panel, "modulate:a", 1.0, dur)
