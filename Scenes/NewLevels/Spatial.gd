extends Spatial

var camera_control : bool = false
var mouse_pos : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT:
			if event.pressed:
				camera_control = true
			else:
				camera_control = false

	if event is InputEventMouseMotion:
		if camera_control:
			rotate_x(-event.speed.y * 0.00003)
			rotation.x = clamp(rotation.x, -PI / 8, PI / 8)
		else:
			mouse_pos = event.position
