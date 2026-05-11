extends Node

const impactFlash = preload("uid://b2qkayj6h3gnq")

@export var rotationSpeed: float = -0.007

@onready var world_environment: WorldEnvironment = $WorldEnvironment

func _on_test_timer_timeout() -> void:
	#var newScene = impactFlash.instantiate()
	#add_child(newScene)
	#newScene.global_position = Vector3(0, 0, -30)
	pass

func _process(delta: float) -> void:
	world_environment.environment.sky_rotation.y += delta * rotationSpeed
 
