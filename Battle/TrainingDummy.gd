extends Enemy

# Called when the node enters the scene tree for the first time.
 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	super._ready()
	maxHealth = 80
	health = maxHealth
