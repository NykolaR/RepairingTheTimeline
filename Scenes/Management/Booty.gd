extends Node



var level : int = 0
var levels : Array = []

signal progress

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _play_game() -> void:
	$AnimationPlayer.play("load")
	yield(self, "progress")
	$MainMenu.visible = false
	var level_one = null
	
