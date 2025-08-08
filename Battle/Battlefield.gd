extends Node2D
var party
var center
var readied_ability
var action_points
var rng

const BatleCharacter = preload("res://Battle/BatleCharacter.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	_set_action_points(5)
	battle_globals._set_battlefield_ref(self)
	var tween = get_tree().create_tween().set_parallel(true)
	#GDscript lacks true constructors the way Java does.
	#this shamefull assemblage is the best I can aproximate.
	var pMember = load("res://Battle/BatleCharacter.tscn")
	rng = RandomNumberGenerator.new()
	party = []
	for i in range(7):#this works for any party size
		#this chunk is a placeholder. Eventually these will be being read in from elsewhere.
		var member = BatleCharacter.instantiate()
		var ability_list = [global_values._get_ability("slash"), global_values._get_ability("heavy_slash")]
		add_child(member)
		member._set_up(str(i), 10, ability_list)
		party.append(member)
		#member._set_name(str(i))
	#hubCoordinates = $PartyArea.get_global_transform()
	_party_space()
	center._open_ability_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _party_space():
	var tween = get_tree().create_tween().set_parallel(true)
	var hub = $PartyArea.get_global_transform().origin# 	Center of the party chunk of the screen
	var adjust = hub
	adjust.y = 0#				Get just the horizontal component
	var nextPosition = hub
	nextPosition.x = 0#			lattitude line, important later
	adjust = adjust / 4 #							movement increment
	
	for x in party.size():
		nextPosition = nextPosition + adjust
		var pMem = party[x]
		pMem.scale = Vector2(1,1)
		tween.tween_property(pMem, "position" ,nextPosition,.1).set_ease(Tween.EASE_OUT)
		#tween.tween_property(pMem, "position" ,hub,0.2).set_ease(Tween.EASE_OUT)
	center = party[0]
	#center = party[0]
	center.scale = Vector2(1.3,1.3)
	
func _center_char(newCenter):
	var pSize = party.size()
	#var offset = party.find(newCenter) + 4
	var offset = party.find(newCenter)
	if offset == pSize:
		return
	elif offset > pSize:
		offset = offset - pSize
	for x in offset:
		for i in pSize-1:
			center._close_ability_menu()
			var temp = party[i-1]
			party[i-1] = party[i]
			party[i] = temp
		_party_space()
		await get_tree().create_timer(0.125).timeout
	center._open_ability_menu()
	
func _loaded_ability_name(new_ab):
	$AbilityReadied.text = new_ab

func _turn():
	if action_points >0:
		print("unused action points")
		return
	#enemy moves
	$TrainingDummy._move()
	for i in party.size():
		party[i]._turn_start()
	_set_action_points(5)


func _on_end_turn_button_button_down():
	_turn()
	pass # Replace with function body.

func _set_action_points(new_ap):
	action_points = new_ap
	$ActionPointPool.text = str(action_points)

func _get_action_points():
	return action_points
	
func _random_moved_character():
	while true:
		var check = party.pick_random()
		if check.has_moved:
			return check
	return

func _on_training_dummy_attacking(attacker, attack):
	print("Dummy turn!")
	ability_scripts._use_ability(attacker, attack, _random_moved_character(), self)
	pass # Replace with function body.
