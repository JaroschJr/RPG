extends Node2D
class_name Enemy
var health
var maxHealth
var mousedOver


# Called when the node enters the scene tree for the first time.
func _ready():
	$HealthBar.value = 100
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click") && mousedOver:
		#print("Clicked")
		if battle_globals.is_ability_selected:
			ability_scripts._use_readied_ability(self)
		

func _on_area_2d_mouse_entered():
	mousedOver = true
	#print("Mouse enters")

func _on_area_2d_mouse_exited():
	mousedOver = false
	#print("Mouse exits")

func _damage(damagepoints, type):
	#type does nothing now, but later attacks will have "types" (slash, blunt, fire, electric, ect)
	#that entities will have different vulnerabilities too.
	health = health - damagepoints
	$HealthBar.value = 100 * health / maxHealth
