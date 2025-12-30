extends State

var heading_towards: Vector2 = Vector2.ZERO


func enter_state():
	heading_towards = ManagerGame.global_map_ref.get_random_point_on_map()
	
	state_machine.root_entity.animated_sprite.play('run')


func process_state(delta):
	if heading_towards != Vector2.ZERO:
		var dir = state_machine.root_entity.global_position.direction_to(heading_towards)
		state_machine.root_entity.global_position += dir * state_machine.root_entity.move_speed * delta
		
		state_machine.root_entity.direction = dir
		
		if state_machine.root_entity.global_position.distance_to(heading_towards) < 8.0:
			heading_towards = Vector2.ZERO
			state_machine.change_state_by_name('EnemyIdle')
