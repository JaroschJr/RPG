extends Node2D
var BattleRef
var Party

# Called when the node enters the scene tree for the first time.
func _ready():
	var pMember = load("res://Battle/BatleCharacter.tscn")
	BattleRef = get_node("/root/Battlefield")
	var party = []
	for i in range(7):
		var member = pMember.instantiate()
		party.append(member)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click"):
		print("it works")
