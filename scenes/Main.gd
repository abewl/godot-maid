extends Node2D
class_name MainMap

# --- Map size ---
@export var min_width := 20
@export var max_width := 40
@export var min_height := 15
@export var max_height := 30

@export var tile_source_id := 0
@export var floor_atlas := Vector2i(2, 2)

@export var wall_top_atlas := Vector2i(1, 0)
@export var wall_bottom_atlas := Vector2i(1, 4)
@export var wall_left_atlas := Vector2i(0, 1)
@export var wall_right_atlas := Vector2i(5, 1)

@export var wall_corner_top_left_atlas := Vector2i(0, 0)
@export var wall_corner_top_right_atlas := Vector2i(5, 0)
@export var wall_corner_bottom_left_atlas := Vector2i(0, 4)
@export var wall_corner_bottom_right_atlas := Vector2i(5, 4)

@onready var ground: TileMapLayer = $Ground
@onready var walls: TileMapLayer = $Walls
@onready var player := $Player

var enemy_controller: EnemyController
var map_width: int
var map_height: int


func _ready() -> void:
	randomize()

	ManagerGame.global_map_ref = self

	generate_map()
	enemy_controller = EnemyController.new()
	add_child(enemy_controller)	

	# Spawn player AFTER map exists
	player.global_position = get_random_point_on_map()


func generate_map() -> void:
	ground.clear()
	walls.clear()

	map_width = randi_range(min_width, max_width)
	map_height = randi_range(min_height, max_height)

	_generate_floor()
	_generate_walls()


func _generate_walls() -> void:
	for x in range(map_width):
		for y in range(map_height):
			var atlas_coords: Vector2i
			
			# Determine which wall tile to use based on position
			# Check corners first (4 corners)
			if x == 0 and y == 0:
				# Top-left corner
				atlas_coords = wall_corner_top_left_atlas
			elif x == map_width - 1 and y == 0:
				# Top-right corner
				atlas_coords = wall_corner_top_right_atlas
			elif x == 0 and y == map_height - 1:
				# Bottom-left corner
				atlas_coords = wall_corner_bottom_left_atlas
			elif x == map_width - 1 and y == map_height - 1:
				# Bottom-right corner
				atlas_coords = wall_corner_bottom_right_atlas
			# Check edges (4 sides)
			elif y == 0:
				# Top wall
				atlas_coords = wall_top_atlas
			elif y == map_height - 1:
				# Bottom wall
				atlas_coords = wall_bottom_atlas
			elif x == 0:
				# Left wall
				atlas_coords = wall_left_atlas
			elif x == map_width - 1:
				# Right wall
				atlas_coords = wall_right_atlas
			else:
				# Not a border position, skip
				continue
			
			walls.set_cell(Vector2i(x, y), tile_source_id, atlas_coords)

func _generate_floor() -> void:
	# Generate floor in the interior only
	for x in range(1, map_width - 1):
		for y in range(1, map_height - 1):
			ground.set_cell(Vector2i(x, y), tile_source_id, floor_atlas)

func is_inside_walls(cell: Vector2i) -> bool:
	return (
		cell.x >= 1
		and cell.y >= 1
		and cell.x <= map_width - 2
		and cell.y <= map_height - 2
	)

func get_random_point_on_map() -> Vector2:
	if map_width < 3 or map_height < 3:
		return Vector2.ZERO

	var x := randi_range(1, map_width - 2)
	var y := randi_range(1, map_height - 2)

	return ground.map_to_local(Vector2i(x, y))
