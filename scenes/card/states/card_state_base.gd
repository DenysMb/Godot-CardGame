extends CardState

func enter(previous_state_path: String, data := {}) -> void:
	card.reparent_requested.emit(card)


func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		finished.emit(CLICKED)


func on_mouse_entered() -> void:
	owner.border_hovered.show()


func on_mouse_exited() -> void:
	owner.border_hovered.hide()
