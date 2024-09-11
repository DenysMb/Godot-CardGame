extends CardState

func enter(previous_state_path: String, data := {}) -> void:
	#card.type.text = CardState.RELEASED
	finished.emit(BASE)


func on_mouse_exited():
	owner.border_hovered.hide()
