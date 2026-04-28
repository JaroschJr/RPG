extends Node2D
var party
var center
var enemies
var readied_ability
var action_points
var rng
var turn_count
#var spawn_list

const BatleCharacter = preload("res://Battle/BatleCharacter.tscn")


#func _init(list_of_enemies = ["training_dummy"]):
#	spawn_list = list_of_enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready runs")
	_set_action_points(5)
	battle_globals._set_battlefield_ref(self)
	#GDscript lacks true constructors the way Java does.
	#this shamefull assemblage is the best I can aproximate.
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
	
	#SpawnEnemies
	#_spawn_enemies(["training_dummy"])
	#This is an example for testing.
	#enemies = []
	#var enemy_left_ref= $EnemyLeftBound.get_global_transform().origin
	#var enemy_right_ref = $EnemyRightBound.get_global_transform().origin
	#var dummy = load("res://Battle/TrainingDummy.tscn")
	#
	#for i in range(3):
		#var enemy = dummy.instantiate()
		#add_child(enemy)
		#enemies.append(enemy)
	#
	#for i in enemies.size():
		#var enemy = enemies[i]
		#enemy.position = enemy_left_ref
		#enemy.position.x = enemy_left_ref.x + (i+1)*(enemy_right_ref.x / (enemies.size() + 1))
		#enemy.attacking.connect(_on_enemy_move)
		#enemy.death.connect(_on_enemy_death)
		#enemy._set_up("Target")
	
	turn_count = 1
	_log_message(str("--- Turn ", turn_count , " ---"))
	

func _spawn_enemies(to_spawn):
	to_spawn.sort()
	enemies = []
	#This is the straight line enemies will be placed along.
	var enemy_left_ref= $EnemyLeftBound.get_global_transform().origin
	var enemy_right_ref = $EnemyRightBound.get_global_transform().origin
	
	#This odd twisty structure is to make sure that repeat enemeis don't need to get loaded every time.
	#To improve performance.
	var new_enemy = to_spawn[0]
	var enemy_path = str("res://Battle/", global_values.get_enemy_filepath(new_enemy) )
	var enemy_type = load(enemy_path)
	while to_spawn.size() > 0:
		if enemy_path != to_spawn[0]: #this will never happen the first time 
			new_enemy = to_spawn[0]
			enemy_path = str("res://Battle/", global_values.get_enemy_filepath(new_enemy) )
			enemy_type = load(enemy_path)
		
		var enemy = enemy_type.instantiate()
		add_child(enemy)
		enemies.append(enemy)
		to_spawn.pop_front()
	
	for i in enemies.size():
		var enemy = enemies[i]
		enemy.position = enemy_left_ref
		enemy.position.x = enemy_left_ref.x + (i+1)*(enemy_right_ref.x / (enemies.size() + 1))
		enemy.attacking.connect(_on_enemy_move)
		enemy.death.connect(_on_enemy_death)
		enemy._set_up("Target")

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
		_log_message("unused action points")
		return
	#enemy moves
	for i in enemies.size():
		enemies[i]._move()
	for i in party.size():
		party[i]._turn_start()
	_set_action_points(5)
	turn_count = turn_count + 1
	_log_message(str("\n--- Turn ", turn_count , " ---"))


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
	
func _log_message(mssg):
	print("logging message:" + mssg)
	$MessageLog.append_text(mssg)
	$MessageLog.append_text("\n")
	$MessageLog.scroll_to_line($MessageLog.get_line_count()-1)
	

func _on_enemy_move(attacker, attack):
	print("Dummy turn!")
	ability_scripts._use_ability(attacker, attack, _random_moved_character(), self)
	pass # Replace with function body.
	
func _on_enemy_death(dead_enemy):
	enemies.remove_at(enemies.find(dead_enemy))
	dead_enemy.queue_free()
	if enemies.size() == 0:
		fight_over()

func fight_over():
	#award gold treasure and whatever else
	scene_switcher.end_battle(self)
	
