extends ColorRect

@onready var animation: AnimationPlayer = $AnimationPlayer

var last_scene_name: String
var scene_dir_path := "res://Scenes/"

func change_scene(from: Node, to_scene_name: String) -> void:
	last_scene_name = from.name

	animation.play("FadeToBlack")
	await animation.animation_finished

	var full_path := scene_dir_path + to_scene_name + ".tscn"
	from.get_tree().call_deferred("change_scene_to_file", full_path)

	animation.play_backwards("FadeToBlack")
