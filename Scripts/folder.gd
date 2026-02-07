extends Area2D

@onready var piskel_1: Sprite2D = $"NewPiskel8_png(4)"
@onready var piskel_2: Sprite2D = $"NewPiskel8_png(4)2"
@onready var piskel_3: Sprite2D = $"NewPiskel8_png(4)3"
@onready var piskel_4: Sprite2D = $"NewPiskel8_png(4)4"

var piskels: Array[Sprite2D] = []

func _ready() -> void:
	piskels = [piskel_1, piskel_2, piskel_3, piskel_4]

	for p in piskels:
		p.visible = false

	var chosen: Sprite2D = piskels.pick_random() as Sprite2D
	chosen.visible = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jack"):
		Global.folder_collected += 1
		queue_free()
