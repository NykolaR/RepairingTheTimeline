extends "res://Scenes/NewLevels/SimulatedObject/Base.gd"

var redMaterial = preload("../../../Assets/red.tres")
var mesh_history = []

func start() -> void:
	set("mode", RigidBody.MODE_RIGID)

func reset() -> void:
	add_history()
	transform = initial_transform
	set("mode", RigidBody.MODE_STATIC)
	

func stop() -> void:
	set("mode", RigidBody.MODE_STATIC)
	
func add_history() -> void:
	# Get the mesh node to duplicate so that no physics is enabled.
	var mesh = self.get_node("MeshInstance").duplicate()
	mesh.set_material_override(redMaterial)
	get_parent().get_parent().add_child(mesh)
	mesh.global_transform = global_transform
	
	if mesh_history.size() < 3:
		mesh_history.append(mesh)
	else:
		var last_mesh = mesh_history.pop_front()
		get_parent().get_parent().remove_child(last_mesh)
		mesh_history.append(mesh)
	
