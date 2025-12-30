extends Node2D
class_name MainMap



func _ready() -> void:
	ManagerGame.global_map_ref = self
	
	for i in range(6):
		var e = preload('res://characters/enemies/Enemy.tscn').instantiate()
		e.global_position = get_random_point_on_map()
		add_child(e)


func get_random_point_on_map() -> Vector2:
	var random_tile = $Ground.get_used_cells().pick_random()
	return random_tile * $Ground.tile_set.tile_size.x
