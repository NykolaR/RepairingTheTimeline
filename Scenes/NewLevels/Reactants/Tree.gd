extends "res://Scenes/NewLevels/SimulatedObject/Base.gd"

var alive : bool = true

func _body_entered(body: Node) -> void:
	if body.is_in_group("simulated"):
		set("mode", RigidBody.MODE_RIGID)
		alive = false
		$Particles.emitting = true
		get_tree().call_group("level", "time_fractured")

func stop() -> void:
	set("mode", RigidBody.MODE_STATIC)
	
	if alive:
		# blue
		pass
	else:
		# red
		pass

func reset() -> void:
	$Particles.emitting = false
	transform = initial_transform
	set("mode", RigidBody.MODE_STATIC)
	alive = true
