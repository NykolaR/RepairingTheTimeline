extends Node



var level : int = 0
var levels : Array = [
	"res://Scenes/NewLevels/Genocide/Geno.tscn",
	"res://Scenes/NewLevels/ForestScene/ForestScene.tscn",
	"res://Scenes/NewLevels/Genocide/Geno.tscn"
]

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
		return
	
	# load next level
	var next_level = load(levels[level])
	var next_level_node = next_level.instance()
	
	$AnimationPlayer.play("load")
	yield(self, "progress")
	
	for child in $LevelHolder.get_children():
		$LevelHolder.remove_child(child)
	
	$LevelHolder.add_child(next_level_node)
	next_level_node.connect("next_level", self, "next_level")
