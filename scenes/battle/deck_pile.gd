class_name DeckPile extends TextureButton

const CARD = preload("res://scenes/card/Card.tscn")

var cards_in_pile: Array[Card] = []

func _ready() -> void:
	var cards_path = "res://resources/cards/"
	var cards = DirAccess.get_files_at(cards_path)
	
	for card_name in cards:
		var card = CARD.instantiate()
		
		var card_resource = load(cards_path + card_name)
		
		card.card_resource = card_resource
		
		cards_in_pile.append(card)


func _on_pressed() -> void:
	print(cards_in_pile)


func draw_card() -> void:
	if cards_in_pile.size() < 1:
		self.disabled = true
		
		return
	
	var hand = $"../Hand"
	
	var random_card_index = randi() % cards_in_pile.size()
	var random_card = cards_in_pile[random_card_index]
	
	cards_in_pile.erase(random_card)
	
	if hand.get_children().size() >= 5:
		burn_card(random_card)
		return
	
	move_card(random_card, hand)
	
	hand.add_child(random_card)
	
	random_card.reparent_requested.connect(_on_card_reparent_requested)
	
	if cards_in_pile.size() < 1:
		self.disabled = true


func burn_card(card: Card) -> void:
	var tween = get_tree().create_tween()
		
	$"..".add_child(card)
	
	card.position = position
	
	tween.tween_property(card, "position", Vector2(position.x, position.y - size.y - 8), 0.75)
	tween.parallel().tween_property(card, "modulate", Color.TRANSPARENT, 0.75)
	tween.tween_callback(card.queue_free)
	


func move_card(card: Card, hand: HBoxContainer) -> void:
	var tween = get_tree().create_tween()
	
	var new_position_x = size.x * hand.get_children().size() + 4 * hand.get_children().size()
	
	tween.tween_property(card, "position", Vector2(position.x, 8), 0)
	tween.tween_property(card, "position", Vector2(new_position_x, 8), 0.75)


func _on_card_reparent_requested(child: Card) -> void:
	var hand = $"../Hand"
	
	child.reparent(hand)
	
	var new_index := clampi(child.original_index, 0, hand.get_child_count())
	
	hand.move_child.call_deferred(child, new_index)
