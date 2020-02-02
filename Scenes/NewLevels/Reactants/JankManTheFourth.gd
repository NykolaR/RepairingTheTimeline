extends Spatial

var redMaterial = preload("res://Assets/red.tres")
var blueMaterial = preload("res://Assets/blue.tres")
var mesh_history = []
var safe
var stopped
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var clone

func _enter_tree():
	stopped = false
	safe = true
	
	add_to_group("simulated")
	clone = duplicate(7)
	$Armature/Head001_end/Area.connect("body_entered",self,"_on_Area_body_entered")
		
# Called when the node enters the scene tree for the first time.
func _ready():
	 pass

func stop():
	stopped = true
	$Armature.physical_bones_stop_simulation()	
	$Armature/Sphere.global_transform = $Armature.get_node("Torso").global_transform
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
	remove_from_group("simulated")

func _on_Area_body_entered(body):
	$Armature.physical_bones_start_simulation() # Replace with function body
	safe = false

func add_history() -> void:
	# Get the mesh node to duplicate so that no physics is enabled.
	if safe:
		$Armature/Sphere.set_material_override(blueMaterial)
	else:
		$Armature/Sphere.set_material_override(redMaterial)
	$Armature/Torso.queue_free()
	$Armature/Head.queue_free()
	$Armature/ArmL.queue_free()
	$Armature/ArmR.queue_free()
	$Armature/LegL.queue_free()
	$Armature/LegR.queue_free()
	
	if mesh_history.size() < 2:
		mesh_history.append(self)
	else:
		var last_mesh = mesh_history.pop_front()
		get_parent().get_parent().remove_child(last_mesh)
		last_mesh.queue_free()
		mesh_history.append(self)
