extends Node

var master_volume: float = 1.0
var music_volume: float = 1.0
var sfx_volume: float = 1.0
var ui_volume: float = 1.0

func _ready():
	_apply_all()

func set_master_volume(value: float):
	master_volume = clamp(value, 0.0, 1.0)
	_set_bus_volume("Master", master_volume)

func set_music_volume(value: float):
	music_volume = clamp(value, 0.0, 1.0)
	_set_bus_volume("Music", music_volume)

func set_sfx_volume(value: float):
	sfx_volume = clamp(value, 0.0, 1.0)
	_set_bus_volume("SFX", sfx_volume)

func set_ui_volume(value: float):
	ui_volume = clamp(value, 0.0, 1.0)
	_set_bus_volume("UI", ui_volume)

func _apply_all():
	_set_bus_volume("Master", master_volume)
	_set_bus_volume("Music", music_volume)
	_set_bus_volume("SFX", sfx_volume)
	_set_bus_volume("UI", ui_volume)

func _set_bus_volume(bus_name: String, linear: float):
	var bus := AudioServer.get_bus_index(bus_name)
	if bus == -1:
		return
	AudioServer.set_bus_volume_db(bus, linear_to_db(linear))
