class_name Card extends Control

signal reparent_requested(card: Card)

@export var card_resource: CardResource

@onready var illustration: TextureRect = %Illustration
@onready var card_name: Label = %CardName
@onready var type: Label = %Type
@onready var description: Label = %Description
@onready var gold: Label = %Gold
@onready var attack: Label = %Attack
@onready var health: Label = %Health
@onready var border_hovered: TextureRect = $BorderHovered

var original_index := 0
var disabled = true

func _ready() -> void:
	if card_resource:
		illustration.texture = card_resource.illustration
		card_name.text = card_resource.card_name
		type.text = card_resource.type
		description.text = card_resource.description
		gold.text = str(card_resource.gold)
		attack.text = str(card_resource.attack)
		health.text = str(card_resource.health)
	
	disable_card()


func enable_card() -> void:
	disabled = false
	modulate = Color(1, 1, 1, 1)


func disable_card() -> void:
	disabled = true
	modulate = Color(1, 1, 1, 0.75)


func _input(event: InputEvent) -> void:
	if %StateMachine and not disabled:
		%StateMachine.on_input(event)


func _on_gui_input(event: InputEvent) -> void:
	if %StateMachine and not disabled:
		%StateMachine.on_gui_input(event)


func _on_mouse_entered() -> void:
	if %StateMachine and not disabled:
		%StateMachine.on_mouse_entered()


func _on_mouse_exited() -> void:
	if %StateMachine and not disabled:
		%StateMachine.on_mouse_exited()
