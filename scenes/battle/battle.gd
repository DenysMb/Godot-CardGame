class_name Battle extends Node2D

@onready var gold_count: Label = %GoldCount
@onready var turn_count: Label = %TurnCount

@onready var deck_pile: DeckPile = $DeckPile
@onready var hand: HBoxContainer = $Hand

var gold: int : set = _set_gold
var current_gold: int : set = _set_current_gold
var turn: int : set = _set_turn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_turn()


func _process(delta: float) -> void:
	for card in hand.get_children():
		if current_gold >= int(card.gold.text):
			card.enable_card()


func start_turn() -> void:
	turn += 1
	gold += 1
	current_gold = gold
	
	if turn > 1:
		deck_pile.draw_card()
	else:
		for i in 3:
			deck_pile.draw_card()
			await get_tree().create_timer(0.75).timeout


func _set_turn(value: int) -> void:
	turn = value
	turn_count.text = str(turn)


func _set_gold(value: int) -> void:
	gold = value if value <= 10 else 10
	gold_count.text = str(gold)


func _set_current_gold(value: int) -> void:
	current_gold = value
	gold_count.text = str(current_gold)


func _on_end_turn_button_pressed() -> void:
	start_turn()
