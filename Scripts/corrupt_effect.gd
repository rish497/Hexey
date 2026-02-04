extends Node2D

@onready var labels := [
	$Container/Label,
	$Container/Label2,
	$Container/Label3,
	$Container/Label4,
	$Container/Label5,
	$Container/Label6,
	$Container/Label7,
	$Container/Label8,
	$Container/Label9,
	$Container/Label10,
	$Container/Label11,
	$Container/Label12,
	$Container/Label13,
	$Container/Label14,
	$Container/Label15,
	$Container/Label16,
	$Container/Label17,
	$Container/Label18,
	$Container/Label19,
]

@onready var container: Control = $Container

var base_scale := {}
var timers := {}
var intervals := {}
var glitching := true

func _ready():
	randomize()

	for l in labels:
		base_scale[l] = l.scale
		timers[l] = randf_range(0.0, 0.15)
		intervals[l] = randf_range(0.1, .3)

func _process(delta):
	if not glitching:
		return

	for l in labels:
		timers[l] -= delta
		if timers[l] <= 0.0:
			timers[l] = intervals[l]
			teleport_and_pop(l)

func teleport_and_pop(l):
	var rect := container.get_rect()

	l.position = Vector2(
		randf_range(0, rect.size.x),
		randf_range(0, rect.size.y)
	)

	var pop_scale := randf_range(0.2, 2)
	l.scale = base_scale[l] * pop_scale

	var pop_duration := randf_range(0.3, 1)

	var t := create_tween()
	t.tween_property(
		l,
		"scale",
		base_scale[l],
		pop_duration
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
