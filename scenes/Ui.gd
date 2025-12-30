extends CanvasLayer
class_name UI



func _ready() -> void:
	ManagerGame.global_ui_ref = self
	
	await get_tree().physics_frame
	
	refresh_hearts_display()


func _physics_process(delta: float) -> void:
		pass


func refresh_hearts_display():
	for i in $HeartsBox.get_children():
		i.queue_free()
	
	for i in ManagerGame.global_player_ref.hurtbox.hp:
		var e = preload('res://assets/ui/Heart.tscn').instantiate()
		e.texture = load('res://resources/icons/heart.tres')
		
		$HeartsBox.add_child(e)
	
	#for i in ManagerGame.global_player_ref.hurtbox.hp:
		#$HeartsBox.get_child(i).texture = load('res://resources/icons/heart.tres')


func _on_pause_pressed() -> void:
	var i = preload('res://components/ui_popups/PauseMenu.tscn').instantiate()
	ManagerGame.pop_to_ui(i)
