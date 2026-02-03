extends Node2D

@onready var area: Area2D = $Area2D
@onready var collision_polygon_2d: CollisionPolygon2D = $CharacterBody2D/CollisionPolygon2D

func _physics_process(_delta):
	var my_tile = get_top_parent_tile(self)
	var covered = false

	for other_area in area.get_overlapping_areas():
		var other_tile = get_top_parent_tile(other_area)
		if other_tile == my_tile:
			continue

		if other_tile.z_index > my_tile.z_index:
			covered = true
			print(self.name, " -> Wall DISABLED because other tile is above: ", other_tile.name)
			break

	# Apply collision disabled state
	collision_polygon_2d.disabled = covered
# Helper: get top-most parent tile node
func get_top_parent_tile(node: Node) -> Node2D:
	var current = node
	while current.get_parent() != null and current.get_parent() is Node2D:
		current = current.get_parent()
	return current as Node2D
