extends Node
class_name StateMachine


@export var initial_state: State
@export var root_entity: Node2D

var is_active = false
var current_state: State


func _ready() -> void:
	
	# once the state and its children (State) are loaded, set the self as reference (i dont like typing the shit for 100x times)
	for i: State in get_children():
		i.state_machine = self
	
	await get_tree().physics_frame
	
	is_active = true
	current_state = initial_state


func _physics_process(delta: float) -> void:
	if current_state and is_active:
		current_state.process_state(delta)


func change_state(state: State):
	if state == current_state:
		return
	
	if current_state:
		current_state.exit_state()
	
	current_state = state
	current_state.enter_state()


func change_state_by_name(state_name: String):
	
	# interesting.. report to godot issues
	#var t = find_child(state_name) if find_child(state_name) != null else null
	#if t:
		#change_state(t as State)
	
	change_state(find_child(state_name) as State)
