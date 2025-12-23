extends State

@export var roll_duration = .15
@export var roll_cooldown = 1.0
var tick = 0.0

var is_rolling = false

var anim_tree

func _ready() -> void:
	await get_tree().physics_frame


func enter_state():
	is_rolling = true


func process_state(delta):
	if is_rolling:
		tick += delta
		
		state_machine.root_entity.velocity = state_machine.root_entity.direction * 600.0
		
		state_machine.root_entity.move_and_slide()
		
		if tick >= roll_duration:
			is_rolling = false
			tick = 0.0
			state_machine.change_state_by_name('Idle')
