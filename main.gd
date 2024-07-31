extends Node2D

var round_count: int = 0
var current_player: int = 0
var player_count: int = 2
var players: Array = []

@export var player_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in range(player_count):
		var player = player_scene.instantiate()
		var spawnLocation = Vector2(i*(50) + 168,88)
		player.position = spawnLocation
		add_child(player)
		players.append(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
"""	var bark_count: int = 0
	for i in players:
		if i.on_bark:
			bark_count += 1
		elif not i.on_bridge:
			print("GAMEOVER")
	if (bark_count > 1):
		print("LA BARQUE ES PLEINE")"""

func next_player():
	var pos = players[current_player].pos()
	if ((pos.x > 1 or pos.x<0) or (pos.y > 14)) and pos != Vector2(296,424):
		print("plouf !")
	if current_player + 1 >= player_count:
		current_player = 0
		round_count += 1
	else:
		current_player += 1
	if players[current_player].on_bark:
		players[current_player].iterate_boat()

func _on_button_pressed():
	if players[current_player].on_bark:
		print("passe un tour")
		next_player()
		return
	await $Dice.roll()
	match $Dice.roll_value:
		1, 2, 3:
			go(Vector2(0, $Dice.roll_value))
			next_player()
		4:
			print("vous devez relancer le dé")
		5:
			if players[current_player].position.x < get_window().size.x/2:
				go(Vector2(1, 0))
			else:
				go(Vector2(-1, 0))
			next_player()
		6:
			players[current_player].to_boat()
			next_player()
	$TextEdit.text = "Au joueur : %s" % current_player
	pass

func go(direction: Vector2):
	# detect if theres forward colision
	var current_pos: Vector2 = players[current_player].pos()
	var next_pos: Vector2 = current_pos + direction
	for i in range(player_count):
		var pos: Vector2 = players[i].pos()
		if i != current_player and not players[i].on_bark:
			print("player different not on bark")
			var vec_to_player = pos - current_pos
			if round(vec_to_player.x*direction.y - vec_to_player.y*direction.x) == 0:
				# vector are colinear
				if (direction.x*vec_to_player.x >= 0 and direction.y*vec_to_player.y >= 0):
					# the vectors are in the same direction
					if sqrt(vec_to_player.x**2+vec_to_player.y**2) <= sqrt(direction.x**2+direction.y**2):
						# The player is on the road
						if direction.x==0:
							players[i].go((next_pos-pos) + Vector2(0,1))
						else:
							players[i].go(direction)
					
	players[current_player].go(direction)
