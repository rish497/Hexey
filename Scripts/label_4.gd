extends Label
@onready var label_4: Label = $"."

func _process(delta: float) -> void:
	label_4.text = "To: " + Global.profile_name
