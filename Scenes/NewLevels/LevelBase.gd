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
	TimeLord.is_simulating = true
	get_tree().call_group("simulated", "start")
	$SimulatedTimer.start()
	set_process(true)

func _pressed() -> void:
	begin_simulation()

func simulation_timeout() -> void:
	pass # Replace with function body.

func rewind_pressed() -> void:
	TimeLord.is_simulating = false
	get_tree().call_group("simulated", "reset")
	$SimulatedTimer.stop()
	$VBoxContainer/HBoxContainer/ProgressBar.value = 0
	set_process(false)
