extends Node2D

var wantedPos: Vector2 = Vector2.ZERO
@export var on_bark: bool = false
@export var on_bridge: bool = true 

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.frame = randi() % 5
	wantedPos = $AnimatedSprite2D.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite2D.position += (wantedPos - $AnimatedSprite2D.position) * delta * 2
	#print($AnimatedSprite2D.position)
	if ($AnimatedSprite2D.position.y < -650):
		on_bridge = false
		on_bark = $AnimatedSprite2D.position.y > -720

func forward(times: int=1):
	wantedPos += times * Vector2(0, -55)
