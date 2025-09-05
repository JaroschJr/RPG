extends Enemy

# Called when the node enters the scene tree for the first time.
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	super._ready()
	maxHealth = 60
	health = maxHealth
	move_list = [global_values._get_ability("slash")]
	strength = 20
	
func _set_up(newname):
	actorName = newname
	$Name.text = actorName
