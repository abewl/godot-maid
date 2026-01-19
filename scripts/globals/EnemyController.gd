extends Node2D
class_name EnemyController

var enemies_alive: Dictionary = {}
var enemies_dead: Dictionary = {}

@export var config_file_path: String = "res://scripts/globals/enemies_config.json"

# enemy_types[type] = {
#   "scene": PackedScene,
#   "spawn": String,
#   "count": int,
#   "enemies": Array
# }
var enemy_types: Dictionary = {}

var _next_enemy_id: int = 0

func _ready() -> void:
	load_enemy_config()
	spawn_enemies()

# ---------------------------
# Load enemy config
# ---------------------------
func load_enemy_config() -> void:
	var file := FileAccess.open(config_file_path, FileAccess.READ)
	if file == null:
		push_error("Failed to open enemy config")
		return

	var json := JSON.new()
	if json.parse(file.get_as_text()) != OK:
		push_error("Error parsing JSON")
		return

	var data: Dictionary = json.data
	var enemy_types_data: Array = data.get("enemy_types", [])

	for enemy_type: Dictionary in enemy_types_data:
		var type_name: String = enemy_type.get("type", "")
		var scene_path: String = enemy_type.get("scene", "")
		var spawn_type: String = enemy_type.get("spawn", "fixed")

		if type_name.is_empty() or scene_path.is_empty():
			continue

		var scene: PackedScene = load(scene_path)
		if scene == null:
			push_error("Failed to load scene: %s" % scene_path)
			continue

		enemy_types[type_name] = {
			"scene": scene,
			"spawn": spawn_type,
			"count": enemy_type.get("count", 0),
			"enemies": enemy_type.get("enemies", [])
		}

# ---------------------------
# Spawn enemies
# ---------------------------
func spawn_enemies() -> void:
	if ManagerGame.global_map_ref == null:
		push_error("Map not ready — cannot spawn enemies")
		return

	for type_name: String in enemy_types.keys():
		var data: Dictionary = enemy_types[type_name]
		var scene: PackedScene = data["scene"]
		var spawn_type: String = data["spawn"]

		if spawn_type == "random":
			_spawn_random(type_name, scene, data["count"])
		elif spawn_type == "fixed":
			_spawn_fixed(type_name, scene, data["enemies"])
		else:
			push_warning("Unknown spawn type: %s" % spawn_type)

# ---------------------------
# Random spawn
# ---------------------------
func _spawn_random(type_name: String, scene: PackedScene, count: int) -> void:
	for i in count:
		var enemy_instance: Node2D = scene.instantiate()
		var pos: Vector2 = ManagerGame.global_map_ref.get_random_point_on_map()

		enemy_instance.global_position = pos
		add_child(enemy_instance)

		var enemy_id := _next_enemy_id
		_next_enemy_id += 1

		enemies_alive[enemy_id] = {
			"instance": enemy_instance,
			"type": type_name,
			"position": pos
		}

# ---------------------------
# Fixed spawn
# ---------------------------
func _spawn_fixed(type_name: String, scene: PackedScene, enemy_list: Array) -> void:
	for enemy_info: Dictionary in enemy_list:
		var enemy_instance: Node2D = scene.instantiate()

		var pos_dict: Dictionary = enemy_info.get("position", {})
		var pos := Vector2(
			pos_dict.get("x", 0),
			pos_dict.get("y", 0)
		)

		enemy_instance.global_position = pos
		add_child(enemy_instance)

		var enemy_id: int = enemy_info.get("id", _next_enemy_id)
		_next_enemy_id = max(_next_enemy_id, enemy_id + 1)

		enemies_alive[enemy_id] = {
			"instance": enemy_instance,
			"type": type_name,
			"position": pos
		}

# ---------------------------
# Optional: call when enemy dies
# ---------------------------
func enemy_died(id: int) -> void:
	if enemies_alive.has(id):
		enemies_dead[id] = enemies_alive[id]
		enemies_alive.erase(id)
