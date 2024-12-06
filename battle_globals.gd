extends Node
var is_ability_selected
var ability_selected
var ability_user
var battlefield_ref

# Called when the node enters the scene tree for the first time.
func _ready():
	is_ability_selected = false
	pass # Replace with function body.

func _set_battlefield_ref(brf):
	battlefield_ref = brf

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _ready_ability(ability, user):
	
	ability_selected = ability
	ability_user = user
	is_ability_selected = true
	#is_ability_selected.ap
	pass
