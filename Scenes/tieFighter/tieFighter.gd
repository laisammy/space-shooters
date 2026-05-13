extends Node3D

class_name tieFighter

const TIE_JUST_FLY = preload("uid://cbksn5aylbx6m")
const TIE_LOSS_OF_CONTROL = preload("uid://blvwms3146av2")
const TIE_TURN_SHOOT = preload("uid://dqb85ekwyi8w4")

# @export var speed: float = 40.0
# @export var engineSoundDistance: float = 100.0
@export var stayStill: bool = false
@export var enemy_Behaviour: enemyBehaviour

@onready var engine_sound: AudioStreamPlayer3D = $engineSound
@onready var player_ref: LinkPlayer = $PlayerRef
@onready var gun: gun = $pivot/gun
@onready var modelMesh: MeshInstance3D = $pivot/TieFighter

func chooseRandomBehaviour() -> void:
	var r: float = randf()
	if r < 0.2:
		enemy_Behaviour = TIE_LOSS_OF_CONTROL.duplicate(true)
	elif r < 0.8:
		enemy_Behaviour = TIE_TURN_SHOOT.duplicate(true)
	else:
		enemy_Behaviour = TIE_JUST_FLY.duplicate(true)
	enemy_Behaviour.setup(self)

func _ready() -> void:
	chooseRandomBehaviour()
	facePlayer()

func _physics_process(delta: float) -> void:
	if !stayStill and enemy_Behaviour:
		enemy_Behaviour.update(delta)
		
func facePlayer() -> void:
	if player_ref.player:
		if player_ref.player_pos.z > global_position.z:
			rotation.y = PI
		else:
			rotation.y = 0

func shoot() -> void:
	gun.shoot()
	
func shootBurst() -> void:
	for i in range(3):
		shoot()
		await get_tree().create_timer(0.2).timeout
		shoot()
		await get_tree().create_timer(0.6).timeout
		shoot()
		await get_tree().create_timer(0.3).timeout


func _on_hit_box_died() -> void:
	queue_free()
