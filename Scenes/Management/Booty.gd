extends Node



var level : int = 0
var levels : Array = ["res://Scenes/NewLevels/ForestScene/ForestScene.tscn"]

signal progress

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _play_game() -> void:
	print("gplay")
	$AnimationPlayer.play("load")
	yield(self, "progress")
	$MainMenu.visible = false
	var level_one = load(levels[0])
	var level_one_node = level_one.instance()
	$LevelHolder.add_child(level_one_node)
	level_one_node.connect("next_level", self, "next_level")

func next_level() -> void:
	level += 1
	if level == levels.size():
		get_tree().quit()
	
	# load next level
