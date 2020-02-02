extends Node

var level : int = 0
var levels : Array = [
	"res://Scenes/NewLevels/Cat/Cat.tscn",
	"res://Scenes/NewLevels/ForestScene/ForestScene.tscn",
	"res://Scenes/NewLevels/Genocide/Geno.tscn"
]

signal progress

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Audio.pitch_shift.pitch_scale = 0.33
	#Audio.distortion.drive = 0.0
	#Audio.lowpass.cutoff_hz = 20500

func _play_game() -> void:
	$AudioStreamPlayer.volume_db = 0
	
	$AudioStreamPlayer2.play()
	$AnimationPlayer.play("load")
	yield(self, "progress")
	$CRTDistortion.visible = false
	$MainMenu.visible = false
	var level_one = load(levels[0])
	var level_one_node = level_one.instance()
	$LevelHolder.add_child(level_one_node)
	level_one_node.connect("next_level", self, "next_level")

func next_level() -> void:
	level += 1
	if level == levels.size():
		$AnimationPlayer.play("load")
		yield(self, "progress")
		
		for child in $LevelHolder.get_children():
			$LevelHolder.remove_child(child)
		
		yield($AnimationPlayer, "animation_finished")
		
		$CRTDistortion.visible = true
		$Credits.play("credits")
		yield($Credits, "animation_finished")
		
		$AnimationPlayer.play("load")
		yield(self, "progress")
		
		$MainMenu.visible = true
		
		yield($AnimationPlayer, "animation_finished")
		
		$MainMenu.active = false
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
