extends Node2D
var ability


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_click():
	get_parent()._ability_used(ability.ability_id)

func _set_up(new_ability):
	ability = new_ability
	$Label.text = ability.ability_name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
