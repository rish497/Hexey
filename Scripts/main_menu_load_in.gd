extends Control

@onready var label_1: Label = $VBoxContainer/Label
@onready var label_2: Label = $VBoxContainer/Label2
@onready var label_3: Label = $VBoxContainer/Label3
@onready var color_rect: ColorRect = $ColorRect
@onready var type_sound: AudioStreamPlayer = $TypeSound

var typing_speed := 0.04

func _ready() -> void:
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
	label_1.visible = false
	label_2.visible = false
	label_3.visible = false

func typewriter(label: Label) -> void:
	var full_text := label.text
	label.text = ""

	for i in full_text.length():
		label.text += full_text[i]
		if full_text[i] != " ":
			type_sound.play()
		await get_tree().create_timer(typing_speed).timeout
