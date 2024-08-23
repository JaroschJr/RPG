extends Node2D

var abilities

signal AbilityUsedSignal(ab_id)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	abilities = []
	var ability = load("res://Battle/AbilityMenuButton.tscn")
	var hub = self.get_global_position()
	var offset = 32
	var nextPosition = hub
	var tween = get_tree().create_tween().set_parallel(true)
	for x in 4:		#4 generic ability placeholders. In the final version, this will be reading out of a list somewhere
		var member = ability.instantiate()
		add_child(member)
		m
		abilities.append(member)
		tween.tween_property(member, "position" ,nextPosition,0.125).set_ease(Tween.EASE_OUT)
		nextPosition.y = nextPosition.y + offset
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _ability_used(ability_id):
	
	AbilityUsedSignal.emit(ability_id)
