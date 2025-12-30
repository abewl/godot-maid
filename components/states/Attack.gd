extends State


var anim_tree

var is_done = false
var is_processed = false

func _ready() -> void:
	await get_tree().physics_frame
	
	anim_tree = state_machine.root_entity.anim_tree
	anim_tree.animation_finished.connect(on_animation_finished)


func process_state(delta):
	if is_done == false:
		anim_tree.get('parameters/playback').travel('attack')
		
		if is_processed == false:
			var obj = state_machine.root_entity.hitcast.collision_result
			if obj:
				for o in obj:
					o['collider'].take_damage(1)
			is_processed = true
	else:
		state_machine.change_state_by_name('Idle')
		is_done = false
		is_processed = false


func on_animation_finished(animation_name: String):
	is_done = true
