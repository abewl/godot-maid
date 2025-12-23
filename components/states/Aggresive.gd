extends State


@export var detection_range = 100.0


func _physics_process(delta: float) -> void:
	if state_machine.root_entity.global_position.distance_to(ManagerGame.global_player_ref.global_position) < detection_range and state_machine.current_state.name != 'Chase':
		state_machine.change_state_by_name('Chase')
