extends CharacterBody3D


class_name Player


const GROUP_PLAYER: String = "player"

@export var flySpeed: float = 30.0
@export var rollSpeed: float = 25.0
@export var tiltSpeed: float = 20.0
@export var maxTiltAngle: float = 20.0
@export var maxRollAngle: float = 30.0

@onready var pivot: Node3D = $pivot

func _enter_tree() -> void:
	add_to_group(GROUP_PLAYER)

func _physics_process(delta: float) -> void:
	var pitchInput = Input.get_axis("pitch_down", "pitch_up")
	var rollInput = Input.get_axis("roll_left", "roll_right")
	
	velocity.y = pitchInput * flySpeed
	velocity.x = rollInput * flySpeed

	move_and_slide()
	updateShipRotation(rollInput, pitchInput, delta)

func updateShipRotation(rollInput: float, pitchInput: float, delta: float) -> void:
	var targetRoll = -rollInput * maxRollAngle
	var targetPitch = pitchInput * maxTiltAngle
	pivot.rotation_degrees.x = lerp(pivot.rotation_degrees.x, targetPitch, delta * tiltSpeed)
	pivot.rotation_degrees.y = lerp(pivot.rotation_degrees.z, targetRoll, delta * rollSpeed)
