extends PhysicsBody

var initial_transform : Transform

func _ready() -> void:
	initial_transform = transform
	add_to_group("simulated")

func start() -> void:
	pass

func stop() -> void:
	pass

func pause() -> void:
	pass

func reset() -> void:
	pass
