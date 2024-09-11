extends CardState

func enter(previous_state_path: String, data := {}) -> void:
	card.original_index = card.get_index()


func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		finished.emit(DRAGGING)
