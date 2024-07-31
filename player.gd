extends Node2D

var init_pos: Vector2
var wanted_pos: Vector2 = Vector2.ZERO
var pos_before_bark: Vector2 = Vector2.ZERO
var boat_counter: int = 0
@export var on_bark: bool = false
@export var on_bridge: bool = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.frame = randi() % 5
	init_pos = position
	if position.x > get_window().size.x/2:
		init_pos += Vector2(-50,0)
	wanted_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += (wanted_pos - position) * delta * 2
	#print($AnimatedSprite2D.position)
	if (position.y < -650):
		on_bridge = false
		on_bark = position.y > -720

func go(direction: Vector2):
	wanted_pos += direction * 48
	
func to_boat():
	pos_before_bark = position
	wanted_pos = Vector2(296,424)
	on_bark = true
	boat_counter = 0

func iterate_boat():
	if boat_counter >= 1:
		on_bark = false
		wanted_pos = pos_before_bark
	boat_counter += 1

func pos():
	return round((wanted_pos-init_pos) / 48)
