extends Area2D
class_name Hurtbox

signal hit
signal zero


@export var hp = 10

var is_disabled = false

func disable(set_disable: bool = true):
	is_disabled = set_disable
	#get_child(0).disable = set_disable


func take_damage(amount: int):
	if is_disabled:
		return
	
	hp -= amount
	
	hit.emit()
	
	if hp <= 0:
		death()


func death():
	zero.emit()
