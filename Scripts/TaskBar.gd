extends Label
@onready var task_bar: Label = $"."

func _ready() -> void:
	task_bar.text = Global.profile_name
