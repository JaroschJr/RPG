extends Node2D
var BattleRef
var mousedOver

# Called when the node enters the scene tree for the first time.
func _ready():
	mousedOver = false
	BattleRef = get_node("/root/Battlefield")


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
