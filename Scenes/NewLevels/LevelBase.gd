extends Spatial

export (float, 1, 10) var simulation_time : float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SimulatedTimer.wait_time = simulation_time
	$VBoxContainer/HBoxContainer/ProgressBar.max_value = simulation_time
	set_process(false)

func _process(delta: float) -> void:
	$VBoxContainer/HBoxContainer/ProgressBar.value = $SimulatedTimer.wait_time - $SimulatedTimer.time_left

func begin_simulation() -> void:
	if TimeLord.is_simulating:
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
	
	print(alive_count, ", ", reactants.size())
	if alive_count == reactants.size():
		print("you win!")
	else:
		print("you lossssed")
	
	get_tree().call_group("simulated", "stop")
	set_process(false)

func rewind_pressed() -> void:
	TimeLord.is_simulating = false
	get_tree().call_group("simulated", "reset")
	$SimulatedTimer.stop()
	$VBoxContainer/HBoxContainer/ProgressBar.value = 0
	set_process(false)
