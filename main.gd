extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var value: int;
	if (not $Dice.is_rolling()):
		value = await $Dice.roll()
	else:
		value = $Dice.roll_value
	print(value)
