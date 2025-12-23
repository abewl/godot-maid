extends State


var vel = Vector2.ZERO
var anim_tree


func _ready() -> void:
	await get_tree().physics_frame
	anim_tree = state_machine.root_entity.anim_tree


func process_state(delta):
	if state_machine == null:
		return
	
	vel.x = Input.get_axis('ui_left', 'ui_right')
	vel.y = Input.get_axis('ui_up', 'ui_down')
	
	if vel != Vector2.ZERO:
		anim_tree.set('parameters/idle/blend_position', vel)
		anim_tree.set('parameters/run/blend_position', vel)
		anim_tree.set('parameters/attack/blend_position', vel)
		
		anim_tree.get('parameters/playback').travel('run')
		
		state_machine.change_state_by_name('Run')
		
		state_machine.root_entity.direction = vel
	else:
		anim_tree.get('parameters/playback').travel('idle')
		
		state_machine.change_state_by_name('Idle')
	
	state_machine.root_entity.velocity = vel * state_machine.root_entity.move_speed
	
	state_machine.root_entity.move_and_slide()
