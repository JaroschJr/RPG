extends Node2D
var abilityName
var ability_id


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_click():
	get_parent()._ability_used(ability_id)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
