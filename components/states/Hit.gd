extends State


func enter_state():
	var facing_away = -state_machine.root_entity.global_position.direction_to(ManagerGame.global_player_ref.global_position)
	
	var t = create_tween()
	t.tween_property(state_machine.root_entity, 'global_position', state_machine.root_entity.global_position + (facing_away * 16.0), .15)
	await t.finished
	state_machine.change_state_by_name('Chase')


func process_state(delta):
	pass
