extends Node
var rng

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _use_readied_ability(target):
	#print("start_ability")
	_use_ability(battle_globals.ability_user, battle_globals.ability_selected, target, battle_globals.battlefield_ref)
	battle_globals.is_ability_selected = false
	battle_globals.ability_selected = null
	
func _use_ability(user, ability, target, battlefield):
	#if battlefield.action_points < ability.ap_cost:
	#	return 
	if  battlefield.action_points < ability.ap_cost:
		print("Not enough AP")
		return
	if user.stamina < ability.sp_cost:
		print("Too tired!")
		return
	
	battlefield._set_action_points( battlefield.action_points - ability.ap_cost)
	user._spend_stamina(ability.sp_cost)
	user._move_poke()
	match ability.ability_id:
		"slash":
			_slash(user, ability, target, battlefield)
		"heavy_slash":
			_heavy_slash(user, ability, target, battlefield)
	
func _slash(user, ability_id, target, battlefield):
	var damage = rng.randi_range(0, user.strength)
	target._damage(damage, "placeholder")
	print(str("Hit for ", damage))
	pass
	
func _heavy_slash(user, ability_id, target, battlefield):
	var damage = rng.randi_range(0, user.strength * 2)
	target._damage(damage, "placeholder")
	print(str("Hit for ", damage))
	pass
	
