extends CharacterBody2D

func _ready() -> void:
	self.visible = false

func _process(delta: float) -> void:
	if Global.level_pass == true:
		self.visible = true
