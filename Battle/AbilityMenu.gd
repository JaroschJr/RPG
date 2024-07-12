extends Node2D

var abilities

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	abilities = []
	var ability = load("res://Battle/AbilityMenuButton.tscn")
	#var hub = self.get_global_transform()
	#var offset = 32
	for x in 4:
		var member = ability.instantiate()
		add_child(member)
		abilities.append(member)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
