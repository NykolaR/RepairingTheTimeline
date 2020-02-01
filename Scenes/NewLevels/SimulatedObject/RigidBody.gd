extends "res://Scenes/NewLevels/SimulatedObject/Base.gd"

func start() -> void:
	set("mode", RigidBody.MODE_RIGID)

func reset() -> void:
	transform = initial_transform
	set("mode", RigidBody.MODE_STATIC)

func stop() -> void:
	set("mode", RigidBody.MODE_STATIC)
