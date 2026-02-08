extends Area2D
@onready var collision_shape_2d_2: CollisionShape2D = $Area2D/CollisionShape2D2

func _ready() -> void:
	self.visible = false

func _process(delta: float) -> void:
	if Global.level_pass==true:
		self.visible = true
		collision_shape_2d_2.set_deferred("disabled", false)
	else:
		collision_shape_2d_2.set_deferred("disabled", true)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Jack"):
		Global.Display_level = true
		collision_shape_2d_2.set_deferred("disabled", true)
