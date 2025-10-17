extends Node

const Ability_Data = preload("res://Ability_Data.gd")
var overworld_scene

var ability_dict = {
	"slash": Ability_Data.new("slash","Slash", 1, 10),
	"heavy_slash":Ability_Data.new("heavy_slash","Heavy Slash", 2, 15)
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_ability(ability_id):
	return ability_dict[ability_id]
