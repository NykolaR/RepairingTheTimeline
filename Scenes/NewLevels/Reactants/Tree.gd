extends "res://Scenes/NewLevels/SimulatedObject/Base.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _body_entered(body: Node) -> void:
	if body.is_in_group("simulated"):
		set("mode", RigidBody.MODE_RIGID)

func stop() -> void:
	set("mode", RigidBody.MODE_STATIC)

func reset() -> void:
	transform = initial_transform
