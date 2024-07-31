extends Node2D

const len: int = 14
@export var padding: int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
"""	for i in range(len):
		var case = $dark.duplicate()
		var spawnLocation = Vector2(0,-i*(50+padding))
		case.position = spawnLocation
		add_child(case)
		case = $bright.duplicate()
		spawnLocation = Vector2(50+padding,-i*(50+padding))
		case.position = spawnLocation
		add_child(case)
	# remove the original rectangles
	$dark.queue_free()
	$bright.queue_free()"""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
