extends CanvasLayer
@onready var transition_color: ColorRect = $TransitionColor
@onready var transition_animation: AnimationPlayer = $TransitionAnimation


var last_scene_name: String
var scene_dir_path= "res://Scenes/" 
func change_scene(from, to_scene_name: String) -> void:
	last_scene_name = from.name
	
	transition_animation.play("transition_out")
	await transition_animation.animation_finished
	
	var full_path = scene_dir_path + to_scene_name + ".tscn"
	from.get_tree().call_deferred("change_scene_to_file", full_path)
	
	transition_animation.play_backwards("transition_out")
	
