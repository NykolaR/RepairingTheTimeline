extends Spatial

var blueMaterial = preload("res://Assets/blue.tres")
var redMaterial = preload("res://Assets/red.tres")
var VaseBroke = preload("res://Scenes/NewLevels/Reactants/VasePieces.tscn")
var mesh_history = []
var alive
var newVase

func _enter_tree():
	alive = true
	visible = true
	add_to_group("simulated")
	add_to_group("reactant")
	$Area.connect("body_entered",self,"_on_Area_body_entered")
		

func _on_Area_body_entered(body):
	if body is RigidBody:
		body.linear_velocity *= 0.7
		body.linear_velocity.y += 2
	alive = false
	get_tree().call_group("level", "time_fractured")
	visible = false
	newVase = VaseBroke.instance()
	get_parent().add_child(newVase)
	newVase.global_transform = global_transform

func stop():
	if not alive:
		newVase.get_node("RigidBody").set("mode", RigidBody.MODE_STATIC)
		newVase.get_node("RigidBody2").set("mode", RigidBody.MODE_STATIC)

func reset():
	add_history()
	visible = true;
	alive = true

func add_history() -> void:
	if alive:
		newVase.get_node("RigidBody").get_node("MeshInstance").set_material_override(blueMaterial)
		newVase.get_node("RigidBody2").get_node("MeshInstance").set_material_override(blueMaterial)
	else:
		newVase.get_node("RigidBody").get_node("MeshInstance").set_material_override(redMaterial)
		newVase.get_node("RigidBody2").get_node("MeshInstance").set_material_override(redMaterial)

	if mesh_history.size() < 2:
		mesh_history.append(newVase)
	else:
		var last_mesh = mesh_history.pop_front()
		last_mesh.queue_free()
		mesh_history.append(newVase)

#func reparent (child, new_parent):
#	child.get_parent().remove_child(child)
#	new_parent.add_child(child)
#	child.set_owner(new_parent)
