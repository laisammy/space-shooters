extends Node3D

class_name asteroid

const explodeZ: float = -20.0

@onready var icosphere: MeshInstance3D = $Icosphere
@onready var hit_box: hitBox = $hitBox

@export var speed: float = -70.0
@export var spinSpeed: float = 2.0

func _physics_process(delta: float) -> void:
	if global_position.z > explodeZ:
		hit_box.blowUp()
		queue_free()
	else:
		icosphere.rotate_y(spinSpeed * delta)
		icosphere.rotate_z(spinSpeed * delta)
		translate_object_local(Vector3.FORWARD * speed * delta)

func _on_hit_box_died() -> void:
	print("_on_hit_box_died(): Asteroid")
	queue_free()
