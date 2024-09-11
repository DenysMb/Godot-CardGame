extends CardState

func enter(previous_state_path: String, data := {}) -> void:
	#card.type.text = CardState.DRAGGING
	
	var battle_node = get_tree().get_first_node_in_group("battle")
	
	if (battle_node):
		owner.reparent(battle_node)


func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("RightClick")
	var confirm = event.is_action_released("LeftClick") or event.is_action_pressed("LeftClick")
	
	if mouse_motion:
		card.global_position = card.get_global_mouse_position() - card.pivot_offset
	
	if cancel:
		finished.emit(BASE)
	elif confirm:
		get_viewport().set_input_as_handled()
		finished.emit(RELEASED)
