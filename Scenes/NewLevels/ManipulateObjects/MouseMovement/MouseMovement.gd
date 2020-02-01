extends "res://MouseObject.gd"

export var movement_vector : Vector3 = Vector3(1, 0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func movement(move : Vector2) -> bool:
	if .movement(move):
		translation += movement_vector.normalized() * move.x * 0.0001
	#move_and_collide(movement_vector.normalized() * move.x * 0.0001)
	
	return false
