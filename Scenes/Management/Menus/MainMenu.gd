extends HBoxContainer

var active : bool = false

signal play_game
signal quit_game

func play_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT and not active:
			active = true
			emit_signal("play_game")

func quit_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT and not active:
			get_tree().quit()
