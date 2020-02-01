extends Area

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _body_entered(body: Node) -> void:
	print("BRO THAT'S A WIN??!!")


func _on_Area_input_event(camera: Node, event: InputEvent, click_position: Vector3, click_normal: Vector3, shape_idx: int) -> void:
	print("hiiii")
