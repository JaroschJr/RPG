extends Node2D
var ability


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_click():
	get_parent()._ability_used(ability)

func _set_up(new_ability):
	ability = new_ability
	$AbilityName.text = str(ability.ability_name)
	$StaminaCost.text = str(ability.sp_cost)
	$APCost.text = str(ability.ap_cost)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
