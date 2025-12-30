extends State


var cool_down_time = 3.0
var tick = 0.0

var can_attack = true


func _physics_process(delta: float) -> void:
	if can_attack == false:
		tick += delta
		
		if tick >= cool_down_time:
			can_attack = true
			tick = 0.0


func enter_state():
	if can_attack == false:
		state_machine.change_state_by_name('EnemyIdle')
		return
	
	can_attack = false
	ManagerGame.global_player_ref.hurtbox.take_damage(1)
	state_machine.change_state_by_name('EnemyIdle')


func process_state(delta):
	pass
