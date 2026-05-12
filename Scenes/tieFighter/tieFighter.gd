extends Node3D

class_name tieFighter

@export var speed: float = 40.0
@export var engineSoundDistance: float = 100.0
@export var stayStill: bool = false

@onready var engine_sound: AudioStreamPlayer3D = $engineSound
@onready var player_ref: LinkPlayer = $PlayerRef
@onready var gun: gun = $pivot/gun

var nearPlayer: bool = false

func _ready() -> void:
	facePlayer()

func _physics_process(delta: float) -> void:
	if !stayStill:
		translate(Vector3.FORWARD * speed * delta)
		
	if !nearPlayer and player_ref.player_less_than_distance(global_position, engineSoundDistance):
		engine_sound.play()
		nearPlayer = true
		
func facePlayer() -> void:
	if player_ref.player:
		if player_ref.player_pos.z > global_position.z:
			rotation.y = PI
		else:
			rotation.y = 0
