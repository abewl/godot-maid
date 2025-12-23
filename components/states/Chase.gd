extends State

@export var max_distance = 70.0

func enter_state():
	pass


func process_state(delta):
	if state_machine.current_state.name == 'Hit':
		return
	
	state_machine.root_entity.nav_agent.target_position = ManagerGame.global_player_ref.global_position
	
	if state_machine.root_entity.global_position.distance_to(ManagerGame.global_player_ref.global_position) > 16:
		state_machine.root_entity.animated_sprite.play('run')
		
		var path = state_machine.root_entity.nav_agent.get_next_path_position()
		var dir = state_machine.root_entity.global_position.direction_to(path)
		state_machine.root_entity.nav_agent.velocity = dir
		
		state_machine.root_entity.direction = dir
		
		state_machine.root_entity.global_position += state_machine.root_entity.safe_vel * state_machine.root_entity.move_speed * delta
	else:
		state_machine.root_entity.animated_sprite.play('idle')
		
		state_machine.change_state_by_name('EnemyAttack')
		return
	
	if state_machine.root_entity.global_position.distance_to(ManagerGame.global_player_ref.global_position) > max_distance:
		state_machine.change_state_by_name('EnemyIdle')
