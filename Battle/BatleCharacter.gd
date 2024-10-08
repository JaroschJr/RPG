extends Node2D
var BattleRef
var mousedOver
var strength

# Called when the node enters the scene tree for the first time.
func _ready():
	mousedOver = false
	BattleRef = get_node("/root/Battlefield")
	strength = 10

# "_init()" is how constructors are declared in gdscript
func _set_up(new_name, new_strength,ability_list):
	strength = new_strength
	_set_name(new_name)
	$AbilityMenu._set_up(ability_list)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click") && mousedOver:
		BattleRef._center_char(self)
		
func _on_area_2d_mouse_entered():
	mousedOver = true
	print("Mouse enters")


func _on_area_2d_mouse_exited():
	mousedOver = false
	print("Mouse exits")
	
func _set_name(newName):
	$CharacterName.text = newName
	
func _close_ability_menu():
	$AbilityMenu.hide()
	
func _open_ability_menu():
	$AbilityMenu.show()
	
func _ability_selected(ability_id):
	battle_globals._ready_ability(ability_id, self)
	print("ability selected")
