extends Node

@export var rotationSpeed: float = -0.007

@onready var world_environment: WorldEnvironment = $WorldEnvironment

func _on_test_timer_timeout() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	world_environment.environment.sky_rotation.y += delta * rotationSpeed
