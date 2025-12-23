extends State


@export var idle_time = randf_range(3, 10)
var tick = 0.0


func change_position():
	state_machine.change_state_by_name('Patrol')


func enter_state():
	pass


func process_state(delta):
	tick += delta
	
	state_machine.root_entity.animated_sprite.play('idle')
	
	if tick > idle_time:
		idle_time = randf_range(3, 10)
		tick = 0.0
		
		change_position()
