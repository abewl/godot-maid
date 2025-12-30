extends Node2D
class_name EnemyController


var enemies_alive = {}
var enemies_dead = {}


@export var config_file_path : String = "res://scripts/globals/enemies_config.json"


var enemy_types = {}

func _ready() -> void:
	load_enemy_config()

	spawn_enemies()

#	print("Alive Enemies: ", enemies_alive.size())

func load_enemy_config() -> void:
	var file = FileAccess.open(config_file_path, FileAccess.READ)
	if file == null:
		push_error("Failed to open enemy config")
		return

	var json_string = file.get_as_text()

	var json := JSON.new()
	var err := json.parse(json_string)
	if err != OK:
		push_error("Error parsing JSON")
		return

	var data = json.data
	var enemy_types_data = data["enemy_types"]

	for enemy_type in enemy_types_data:
		var type = enemy_type["type"]
		var scene_path = enemy_type["scene"]

		var scene: PackedScene = load(scene_path)
		if scene == null:
			push_error("Failed to load scene: %s" % scene_path)
			continue

		enemy_types[type] = {
			"scene": scene,
			"enemies": enemy_type["enemies"]
		}

func spawn_enemies() -> void:
	# Spawn all enemies listed in the config, based on type
	for type in enemy_types.keys():
		var enemy_data = enemy_types[type]
		var scene = enemy_data["scene"]
		var enemy_list = enemy_data["enemies"]

		# For each enemy of this type, instantiate and position it
		for enemy_info in enemy_list:
			var enemy_instance = scene.instantiate()
			var position = Vector2(enemy_info["position"]["x"], enemy_info["position"]["y"])
			enemy_instance.global_position = position

			# Store reference to the enemy instance
			enemies_alive[enemy_info["id"]] = {
				"instance": enemy_instance,
				"type": type,
				"position": position
			}

			# Add the enemy to the scene
			add_child(enemy_instance)

# Call this function when an enemy dies to track it
# func enemy_died(id: int) -> void:
# 	if enemies_alive.has(id):
# 		enemies_dead[id] = enemies_alive[id]
# 		enemies_alive.erase(id)
# 		print("Enemy with ID ", id, " has died.")
