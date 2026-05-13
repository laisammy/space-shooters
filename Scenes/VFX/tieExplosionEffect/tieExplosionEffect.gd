extends Node3D

@onready var sparks: GPUParticles3D = $sparks
@onready var explodeSound: AudioStreamPlayer3D = $explode

func _ready() -> void:
	sparks.emitting = true
	await explodeSound.finished
	queue_free()
	
