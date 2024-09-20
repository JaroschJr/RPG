extends Node2D
var party
var center
var readied_ability

const BatleCharacter = preload("res://Battle/BatleCharacter.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	battle_globals._set_battlefield_ref(self)
	var tween = get_tree().create_tween().set_parallel(true)
	#GDscript lacks true constructors the way Java does.
	#this shamefull assemblage is the best I can aproximate.
	var pMember = load("res://Battle/BatleCharacter.tscn")
	party = []
	for i in range(7):
		var member = BatleCharacter.instantiate()
		var ability_list = ["slash", "heavy_slash"]
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
		tween.tween_property(pMem, "position" ,nextPosition,0.125).set_ease(Tween.EASE_OUT)
		#tween.tween_property(pMem, "position" ,hub,0.2).set_ease(Tween.EASE_OUT)
	center = party[3]
	center.scale = Vector2(1.2,1.2)
	
func _center_char(newCenter):
	var offset = party.find(newCenter) + 4
	if offset == 7:
		return
	elif offset > 7:
		offset = offset - 7
	for x in offset:
		for i in party.size()-1:
			center._close_ability_menu()
			var temp = party[i-1]
			party[i-1] = party[i]
			party[i] = temp
		_party_space()
		await get_tree().create_timer(0.125).timeout
	center._open_ability_menu()
	
func _loaded_ability_name(new_ab):
	$AbilityReadied.text = new_ab
