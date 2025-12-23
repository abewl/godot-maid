extends CharacterBody2D
class_name Player


var direction = Vector2.ZERO
var move_speed = 100.0

@onready var anim_tree = $AnimationTree
@onready var state_machine: StateMachine = $StateMachine
@onready var hitcast = $Aim/Hitcast
@onready var hurtbox = $Hurtbox

var mp = 25
var gold = 100
var hp_max = 6

var can_move = true

func _ready() -> void:
	ManagerGame.global_player_ref = self
	
	hurtbox.hp = hp_max


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack()
	if Input.is_action_just_pressed("roll"):
		state_machine.change_state_by_name('Roll')
	
	$Aim.look_at(global_position + direction)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released('mouse_up'):
		if $Camera2D.zoom < Vector2(2, 2):
			$Camera2D.zoom += Vector2(0.1, 0.1)
	
	if event.is_action_released('mouse_down'):
		if $Camera2D.zoom > Vector2(.7, .7):
			$Camera2D.zoom -= Vector2(0.1, 0.1)


func attack():
	state_machine.change_state_by_name('Attack')


func death():
	hurtbox.disable()
	can_move = false
	
	anim_tree.active = false
	$AnimationPlayer.active = true
	$AnimationPlayer.play("death")
	
	get_tree().paused = true


func _on_hurtbox_hit() -> void:
	$HitFX.play("hit")
	
	ManagerGame.global_ui_ref.refresh_hearts_display()


func _on_hurtbox_zero() -> void:
	state_machine.change_state_by_name('Death')
