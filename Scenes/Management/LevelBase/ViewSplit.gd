extends HBoxContainer

func _input(event : InputEvent) -> void:
	$Past/Viewport.input(event)
	
	if event.is_action_pressed("ui_accept"):
		TimeLord.is_simulating = true
