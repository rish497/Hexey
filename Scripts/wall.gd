extends Node2D

@onready var area: Area2D = $Area2D
@onready var collision: CollisionPolygon2D = $CharacterBody2D/CollisionPolygon2D


func _ready() -> void:
	area.monitoring = true
	area.monitorable = true

	area.area_entered.connect(_recheck_coverage)
	area.area_exited.connect(_recheck_coverage)

	call_deferred("_recheck_coverage")


func _recheck_coverage(_a: Area2D = null) -> void:
	await get_tree().physics_frame

	var my_tile := get_top_parent_tile(self)
	var covered := false

	for other_area in area.get_overlapping_areas():
		var other_tile := get_top_parent_tile(other_area)

		if other_tile == my_tile:
			continue

		if other_tile.z_index > my_tile.z_index:
			covered = true
			break

	collision.disabled = covered


func get_top_parent_tile(node: Node) -> Node2D:
	var current := node
	while current.get_parent() and current.get_parent() is Node2D:
		current = current.get_parent()
	return current as Node2D
