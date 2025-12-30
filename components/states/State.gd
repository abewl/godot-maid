extends Node
class_name State

var state_machine: StateMachine

## Override this function on each instance of this State node.
## It is not meant to be implemented directly here.
func process_state(delta):
	pass


func enter_state():
	pass


func exit_state():
	pass
