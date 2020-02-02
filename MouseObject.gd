extends KinematicBody

var moving : bool = false
var move : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if moving and event is InputEventMouseMotion:
		movement(event.speed)
	
	if moving and event is InputEventMouseButton:
		if not event.pressed:
			moving = false
			
			if has_node("MeshInstance"):
				var mesh = get_node("MeshInstance") as MeshInstance
				
				if mesh:
					if mesh.material_override is SpatialMaterial:
						mesh.material_override.emission_energy = 0

func movement(move : Vector2) -> bool:
	return not TimeLord.is_simulating

func input_event(camera: Node, event: InputEvent, click_position: Vector3, click_normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			moving = true

func _mouse_entered() -> void:
	if TimeLord.is_simulating:
		return
	
	if has_node("MeshInstance"):
		var mesh = get_node("MeshInstance") as MeshInstance
		
		if mesh:
			if mesh.material_override is SpatialMaterial:
				mesh.material_override.emission_energy = 1

func _mouse_exited() -> void:
	if has_node("MeshInstance"):
		var mesh = get_node("MeshInstance") as MeshInstance
		
		if mesh and not moving:
			if mesh.material_override is SpatialMaterial:
				mesh.material_override.emission_energy = 0
