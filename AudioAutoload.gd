extends Node

var pitch_shift : AudioEffectPitchShift
#var lowpass : AudioEffectLowPassFilter
#var distortion : AudioEffectDistortion

func _ready() -> void:
	#distortion = AudioServer.get_bus_effect(0, 0)
	pitch_shift = AudioServer.get_bus_effect(1, 0)
	#lowpass = AudioServer.get_bus_effect(0, 1)
