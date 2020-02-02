extends Spatial

var jankCorpse = preload("res://Scenes/NewLevels/POC2/JankCorpse.tscn")
var blueMaterial = preload("res://Assets/blue.tres")
var mesh_history = []
var safe
var stopped
var clone

func _enter_tree():
	stopped = false
	safe = true
	
	add_to_group("simulated")
	clone = duplicate(7)
	$Armature/Head001_end/Area.connect("body_entered",self,"_on_Area_body_entered")
		

func stop():
	stopped = true
	$Armature.physical_bones_stop_simulation()	
	$Armature/Sphere.global_transform = $Armature/Torso.global_transform
	#$Armature/Torso.weight = 0
	#$Armature/Head.weight = 0
	#$Armature/ArmL.weight = 0
	#$Armature/ArmR.weight = 0
	#$Armature/LegL.weight = 0
	#$Armature/LegR.weight = 0
	#$Armature/Torso.set_physics_process(false)
	#$Armature/Head.set_physics_process(false)
	#$Armature/ArmL.set_physics_process(false)
	#$Armature/ArmR.set_physics_process(false)
	#$Armature/LegL.set_physics_process(false)
	#$Armature/LegR.set_physics_process(false)
	#$Armature/Torso.set("mode", RigidBody.MODE_STATIC)
	#$Armature/Head.set("mode", RigidBody.MODE_STATIC)
	#$Armature/ArmL.set("mode", RigidBody.MODE_STATIC)
	#$Armature/ArmR.set("mode", RigidBody.MODE_STATIC)
	#$Armature/LegL.set("mode", RigidBody.MODE_STATIC)
	#$Armature/LegR.set("mode", RigidBody.MODE_STATIC)

func reset():
	if not stopped:
		return
	add_history()
	get_parent().add_child(clone)
	clone.mesh_history = mesh_history
	mesh_history = []
	queue_free()

func _on_Area_body_entered(body):
	$Armature.physical_bones_start_simulation() # Replace with function body
	if body is RigidBody:
		body.linear_velocity *= 0.7
		body.linear_velocity.y += 2
	safe = false

func add_history() -> void:
	var corpse = jankCorpse.instance()
	get_parent().add_child(corpse)
	corpse.global_transform = $Armature/Sphere.global_transform
	if safe:
		corpse.get_node("MeshInstance").set_material_override(blueMaterial)
	
	if mesh_history.size() < 2:
		mesh_history.append(corpse)
	else:
		var last_mesh = mesh_history.pop_front()
		last_mesh.queue_free()
		mesh_history.append(corpse)

#func reparent (child, new_parent):
#	child.get_parent().remove_child(child)
#	new_parent.add_child(child)
#	child.set_owner(new_parent)
