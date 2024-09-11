class_name CardState extends State

const BASE = "Base"
const CLICKED = "Clicked"
const DRAGGING = "Dragging"
const RELEASED = "Released"

var card: Card

func _ready() -> void:
	await owner.ready
	card = owner as Card
	assert(card != null, "The CardState state type must be used only in the card scene. It needs the owner to be a Card node.")
