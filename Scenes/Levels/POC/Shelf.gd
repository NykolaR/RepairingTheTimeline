extends Area

var mouse_overlap : bool = false
var moving : bool = false
var movement : Vector2 = Vector2()

func _ready() -> void:
	pass # Replace with function body.

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT and mouse_overlap:
			moving = true
		
		if moving and not event.pressed and event.button_index == BUTTON_LEFT:
			moving = false
	
	if event is InputEventMouseMotion:
		movement = event.speed

func _mouse_entered() -> void:
	print("mouse entered")
	mouse_overlap = true

func _mouse_exited() -> void:
	print("mouse exited")
	mouse_overlap = false

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		get_parent().move_and_collide(Vector3(1 * 0.1, 0, 0))
	if Input.is_action_pressed("ui_left"):
		get_parent().move_and_collide(Vector3(-1 * 0.1, 0, 0))
	#if moving:
	#	get_parent().move_and_slide(Vector3(movement.x * 0.01, 0, 0))
