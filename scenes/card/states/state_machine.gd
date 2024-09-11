class_name StateMachine

extends Node

@export var initial_state: State = null

## The current state of the state machine.
@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()

func _ready() -> void:
	# Give every state a reference to the state machine.
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	# State machines usually access data from the root node of the scene they're part of: the owner.
	# We wait for the owner to be ready to guarantee all the data and nodes the states may need are available.
	await owner.ready
	state.enter("")


func on_input(event: InputEvent) -> void:
	state.on_input(event)


func on_gui_input(event: InputEvent) -> void:
	state.on_gui_input(event)


func on_mouse_entered() -> void:
	state.on_mouse_entered()


func on_mouse_exited() -> void:
	state.on_mouse_exited()


func _transition_to_next_state(target_state_path: String) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path)
