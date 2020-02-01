extends HBoxContainer

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		TimeLord.is_simulating = true
