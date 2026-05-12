extends Node3D


class_name Spawner


@export var x_range: Vector2 = Vector2(-20, 20)
@export var y_range: Vector2 = Vector2(-20, 20)
@export var enabled: bool = true
@onready var tie_timer: Timer = $TieTimer
@onready var asteroid_timer: Timer = $AsteroidTimer

var playerLaserPool: laserPool

const IMPACT_FLASH = preload("uid://b2qkayj6h3gnq")
const PLAYER_LASER = preload("uid://bsjnopnp5qi12")

enum SceneNames { impactFlash }
enum LaserTypes { playerLaser, tieLaser }

const scenesDictionary: Dictionary[int, PackedScene] = {
	SceneNames.impactFlash: IMPACT_FLASH
}

func _ready() -> void:
	playerLaserPool = laserPool.new(10 , PLAYER_LASER, self, "PlayerLaser")
	
	SignalHub.on_CreateOneOff.connect(on_CreateOneOff)
	SignalHub.on_CreateLaser.connect(on_CreateLaser)


func add_with_transform(ob: Node3D, p_tr: Transform3D) -> void:
	add_child(ob)
	ob.global_transform = p_tr


func add_with_position(ob: Node3D, p_pos: Vector3) -> void:
	add_child(ob)
	ob.global_position = p_pos


func on_create_packed_scene(p_tr: Transform3D, ps: PackedScene) -> void:
	var ns = ps.instantiate()
	call_deferred("add_with_transform", ns, p_tr)

func on_CreateOneOff(pPos: Vector3, sceneName: Spawner.SceneNames) -> void:
	if !scenesDictionary.has(sceneName):
		return
	var newScene = scenesDictionary[sceneName].instantiate()
	call_deferred("add_with_position", newScene, pPos)
	print("on_CreateOneOff")

func on_CreateLaser(pTr: Transform3D, laserType: Spawner.LaserTypes) -> void:
	match laserType:
		LaserTypes.playerLaser: playerLaserPool.activateNextScene(pTr)


func _on_tie_timer_timeout() -> void:
	pass


func _on_asteroid_timer_timeout() -> void:
	pass
