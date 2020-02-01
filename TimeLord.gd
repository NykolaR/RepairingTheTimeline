extends Node

var is_simulating : bool = false setget set_simulating

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_simulating(new : bool) -> void:
	is_simulating = new
	
	if is_simulating:
		get_tree().call_group("simulate", "simulation")
