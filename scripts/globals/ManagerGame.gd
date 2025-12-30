extends Node

var SAVE_PATH = 'user://player_data.json'


var player_data = {}


var global_map_ref: MainMap
var global_player_ref: Player
var global_ui_ref: UI


func _ready() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		player_data = get_data(SAVE_PATH)
	else:
		player_data = get_data("res://scripts/player_data.json")


func save_game():
	var f = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	f.store_string(JSON.stringify(player_data))
	f.close()


func load_game():
	pass


func get_data(path: String):
	var f = FileAccess.open(path, FileAccess.READ)
	var j = JSON.new()
	j.parse(f.get_as_text())
	
	return j.data


func pop_to_ui(instance):
	for i in $Popups.get_children():
		i.queue_free()
	
	$Popups.add_child(instance)
