extends Label
@onready var label_4: Label = $"."

func _ready() -> void:
	label_4.text = "To: " + Global.profile_name
