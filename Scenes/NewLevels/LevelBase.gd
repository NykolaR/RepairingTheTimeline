extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		TimeLord.is_simulating = true
		for child in $Rigids.get_children():
			if child is RigidBody:
				child.mode = RigidBody.MODE_RIGID
