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
		var spawnLocation = Vector2(i*(55) + 225,900-(45/2)-3)
		player.position = spawnLocation
		add_child(player)
		players.append(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var bark_count: int = 0
	for i in players:
		if i.on_bark:
			bark_count += 1
		elif not i.on_bridge:
			print("GAMEOVER")
	if (bark_count > 1):
		print("LA BARQUE ES PLEINE")

func next_player():
	if current_player + 1 >= player_count:
		current_player = 0
		round_count += 1
	else:
		current_player += 1

func _on_button_pressed():
	await $Dice.roll()
	players[current_player].forward($Dice.roll_value)
	next_player()
	$TextEdit.text = "Au joueur : %s" % current_player
	pass
