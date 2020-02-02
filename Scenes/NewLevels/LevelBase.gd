extends Spatial

signal next_level

var stage_won : bool = false

export (float, 1, 10) var simulation_time : float = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SimulatedTimer.wait_time = simulation_time
	$VBoxContainer/HBoxContainer/ProgressBar.max_value = simulation_time
	set_process(false)
	begin_simulation()
	flash_rewind()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("play"):
		_pressed()
	if event.is_action_pressed("rewind"):
		rewind_pressed()

func _process(delta: float) -> void:
	$VBoxContainer/HBoxContainer/ProgressBar.value = $SimulatedTimer.wait_time - $SimulatedTimer.time_left

func begin_simulation() -> void:
	if TimeLord.is_simulating or stage_won:
		return
	
	TimeLord.is_simulating = true
	get_tree().call_group("simulated", "start")
	$SimulatedTimer.start()
	set_process(true)

func _pressed() -> void:
	begin_simulation()

func simulation_timeout() -> void:
	var alive_count : int = 0
	
	var reactants : Array = get_tree().get_nodes_in_group("reactant")
	for reactant in reactants:
		if reactant.alive:
			alive_count += 1
	
	if not alive_count == reactants.size():
		stage_won = true
		$AnimationPlayer.play("FadeWin")
		return
	
	get_tree().call_group("simulated", "stop")
	set_process(false)

func rewind_pressed() -> void:
	if stage_won:
		return
	
	$VBoxContainer/HBoxContainer/Rewind/RewindAnimationPlayer.seek(0, true)
	$VBoxContainer/HBoxContainer/Rewind/RewindAnimationPlayer.stop(true)
	TimeLord.is_simulating = false
	get_tree().call_group("simulated", "reset")
	$SimulatedTimer.stop()
	$VBoxContainer/HBoxContainer/ProgressBar.value = 0
	set_process(false)

func flash_rewind() -> void:
	$VBoxContainer/HBoxContainer/Rewind/RewindAnimationPlayer.play("FlashRewind")

func nextlevel_pressed(event: InputEvent) -> void:
	if stage_won:
		emit_signal("next_level")
