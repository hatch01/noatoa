extends Node2D

@export
var roll_value: int;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func roll():
	start_animation()
	await get_tree().create_timer(1.0).timeout
	stop_animation()
	roll_value = $Button/AnimatedSprite2D.frame + 1
	return roll_value

func start_animation():
	$Button/AnimatedSprite2D/AnimationPlayer.play("dice_animation")
	
func stop_animation():
	$Button/AnimatedSprite2D/AnimationPlayer.stop()

func toggle_animation():
	if is_rolling():
		stop_animation()
	else:
		start_animation()

func is_rolling() -> bool:
	return $Button/AnimatedSprite2D/AnimationPlayer.is_playing()
	
func random_frame():
	# Don't want to linger on one side

	var last_frame = $Button/AnimatedSprite2D.frame
	while $Button/AnimatedSprite2D.frame == last_frame:
		$Button/AnimatedSprite2D.frame = randi() % randi() % 6

func _on_button_pressed():
	if (not is_rolling()):
		await roll()
