extends Spatial

signal next_level

var stage_won : bool = false
var stage_lost : bool = false

export var pitch_shift : AudioEffectPitchShift

signal reset_bodies

export (float, 1, 10) var simulation_time : float = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CRTDistortion.visible = false
	pitch_shift = Audio.pitch_shift
	$SimulatedTimer.wait_time = simulation_time
	TimeLord.is_simulating = false
	#$VBoxContainer/HBoxContainer/ProgressBar.max_value = simulation_time
	begin_simulation()
	flash_rewind()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("play"):
		_pressed()
	if event.is_action_pressed("rewind"):
		rewind_pressed()

func _process(delta: float) -> void:
	$VBoxContainer/HBoxContainer/ProgressBar.value = ($SimulatedTimer.wait_time - $SimulatedTimer.time_left) / $SimulatedTimer.wait_time

func begin_simulation() -> void:
	if TimeLord.is_simulating or stage_won:
		return
	
	$AnimationPlayer.seek(0, true)
	$AnimationPlayer.stop()
	TimeLord.is_simulating = true
	get_tree().call_group("simulated", "start")
	$SimulatedTimer.start()
	set_process(true)

func time_fractured() -> void:
	if not stage_lost:
		$AnimationPlayer.play("LoseDisplay")
		stage_lost = true

func _pressed() -> void:
	begin_simulation()

func simulation_timeout() -> void:
	var alive_count : int = 0
	
	var reactants : Array = get_tree().get_nodes_in_group("reactant")
	for reactant in reactants:
		if reactant.alive:
			alive_count += 1
	
	if alive_count == reactants.size():
		stage_won = true
		$AnimationPlayer.play("FadeWin")
	
	get_tree().call_group("simulated", "stop")
	set_process(false)

func rewind_pressed() -> void:
	if stage_won or $SimulatedTimer.time_left > 0:
		return
	
	stage_lost = false
	$SimulatedTimer.stop()
	set_process(false)
	$RewindAnimation.play("Rewind")
	yield(self, "reset_bodies")
	$AnimationPlayer.seek(0, true)
	$AnimationPlayer.stop()
	get_tree().call_group("simulated", "reset")
	yield($RewindAnimation, "animation_finished")
	
	$VBoxContainer/HBoxContainer/Rewind/RewindAnimationPlayer.seek(0, true)
	$VBoxContainer/HBoxContainer/Rewind/RewindAnimationPlayer.stop(true)
	
	TimeLord.is_simulating = false
	$VBoxContainer/HBoxContainer/ProgressBar.value = 0

func flash_rewind() -> void:
	$VBoxContainer/HBoxContainer/Rewind/RewindAnimationPlayer.play("FlashRewind")

func nextlevel_pressed(event: InputEvent) -> void:
	if stage_won:
		if event is InputEventMouseButton:
			if event.pressed and event.button_index == BUTTON_LEFT:
				emit_signal("next_level")
