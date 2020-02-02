extends "res://Scenes/NewLevels/SimulatedObject/Base.gd"

var blueMaterial = preload("res://Assets/blue.tres")
var redMaterial = preload("res://Assets/red.tres")
var newTreeSource = preload("res://Scenes/NewLevels/Reactants/SimpleTree.tscn")

var alive : bool = true
var mesh_history = []

func _body_entered(body: Node) -> void:
	if body.is_in_group("simulated"):
		$AudioStreamPlayer3D.play()
		set("mode", RigidBody.MODE_RIGID)
		alive = false
		$Particles.emitting = true
		get_tree().call_group("level", "time_fractured")

func stop() -> void:
	set("mode", RigidBody.MODE_STATIC)

func reset() -> void:
	add_history()
	$Particles.emitting = false
	transform = initial_transform
	set("mode", RigidBody.MODE_STATIC)
	alive = true

func add_history() -> void:
	var newTree = newTreeSource.instance()
	get_parent().add_child(newTree)
	newTree.global_transform = transform
	if alive:
		newTree.set_material_override(blueMaterial)
	else:
		newTree.set_material_override(redMaterial)

	if mesh_history.size() < 2:
		mesh_history.append(newTree)
	else:
		var last_mesh = mesh_history.pop_front()
		last_mesh.queue_free()
		mesh_history.append(newTree)
