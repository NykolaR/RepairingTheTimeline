extends "res://Scenes/NewLevels/SimulatedObject/Base.gd"

var alive : bool = true

func _body_entered(body: Node) -> void:
	if body.is_in_group("simulated"):
		set("mode", RigidBody.MODE_RIGID)
		alive = false
		$Particles.emitting = true

func stop() -> void:
	set("mode", RigidBody.MODE_STATIC)

func reset() -> void:
	$Particles.emitting = false
	transform = initial_transform
	alive = true
