extends Node
var ability_dict = {
	"slash":"Slash",
	"heavy_slash":"Heavy Slash"
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_ability_name(ability_id):
	return ability_dict[ability_id]
