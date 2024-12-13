extends Node2D
var BattleRef
var mousedOver
var strength
var max_stamina
var stamina
var max_life
var life
var has_moved
var rest_factor

# Called when the node enters the scene tree for the first time.
func _ready():
	mousedOver = false
	BattleRef = get_node("/root/Battlefield")
	has_moved = false
	$MovedIndicatorTrue.hide()
	
	

# "_init()" is how constructors are declared in gdscript
func _set_up(new_name, new_strength,ability_list):
	strength = new_strength
	_set_name(new_name)
	$AbilityMenu._set_up(ability_list)
	max_stamina = 100
	stamina = 100
	max_life = 100
	life = 100
	rest_factor = 10
	#Because of how the textures work, the empty space above the bar is "part of" the mesh.
	#So a 'full' bar is 90% instead of 100
	$BarScalingParent1/LifeBar.value = 90
	$BarScalingParent2/StaminaBar.value = 90
	
func _ui_update():
	$BarScalingParent1/LifeBar.value = (life * 90) / max_life
	$BarScalingParent2/StaminaBar.value = (stamina * 90) / max_stamina

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click") && mousedOver:
		BattleRef._center_char(self)
		
func _on_area_2d_mouse_entered():
	mousedOver = true
	#print("Mouse enters")


func _on_area_2d_mouse_exited():
	mousedOver = false
	#print("Mouse exits")
	
func _set_name(newName):
	$CharacterName.text = newName
	
func _close_ability_menu():
	$AbilityMenu.hide()
	
func _open_ability_menu():
	$AbilityMenu.show()
	
func _ability_selected(ability):
	battle_globals._ready_ability(ability, self)
	#print("ability selected")
	
func _move_poke():
	has_moved = true
	$MovedIndicatorTrue.show()
	
func _spend_stamina(sp_fee):
	stamina = stamina - sp_fee
	_ui_update()
	

func _damage(damagepoints, type):
	#apply resistiances first.
	if damagepoints > stamina:
		damagepoints = damagepoints - stamina
		stamina = 0
		#possibly some extra damage modification here
		life = life - damagepoints
	else:
		stamina = stamina - damagepoints
	_ui_update()
	

func _turn_start():
	#anything that happens at the end of a turn happens here. Countdowns on statuse efects, DOT effects, and so on.
	#print("starting new turn")
	if has_moved == false:
		stamina = stamina + rest_factor
		if stamina > max_stamina:
			stamina = max_stamina
	has_moved = false
	$MovedIndicatorTrue.hide()
	_ui_update()
	
	
