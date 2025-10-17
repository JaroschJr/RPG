extends Node2D
var turn
var fight_countdown
var rng

func _ready():
	global_values.overworld_scene = self
	rng = RandomNumberGenerator.new()
	fight_countdown = rng.randi_range(5,10)
	turn = 1
	turn_display_update()


func _draw():
	for x in range(0, 1152, 64):
		draw_line(Vector2(x, 0), Vector2(x, 640), Color8(0, 0, 0), 1.5)
	for y in range(0, 640, 64):
		draw_line(Vector2(0, y), Vector2(1152, y), Color8(0, 0, 0), 2)


func turn_pass(turns):
	turn = turn + turns
	turn_display_update()
	fight_countdown = fight_countdown - 1
	if fight_countdown < 1:
		fight_countdown = rng.randi_range(5,10)
		var new_battle = load("res://Battle/Battlefield.tscn").instantiate()
		scene_switcher.start_battle(new_battle)
	pass # Replace with function body.

func turn_display_update():
	get_node("Player/Camera2D/Turn_display").text = ("Turn\t" + str(turn))
