extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _use_readied_ability(target):
	_use_ability(battle_globals.ability_user, battle_globals.ability_selected, target, battle_globals.battlefield_ref)
	
func _use_ability(user, ability_id, target, battlefield):
	print("Attack!")
