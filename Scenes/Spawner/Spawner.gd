extends Node3D


class_name Spawner


@export var x_range: Vector2 = Vector2(-20, 20)
@export var y_range: Vector2 = Vector2(-20, 20)
@export var enabled: bool = true
@onready var tie_timer: Timer = $TieTimer
@onready var asteroid_timer: Timer = $AsteroidTimer

var playerLaserPool: laserPool
var tieLaserPool: laserPool

const IMPACT_FLASH = preload("uid://b2qkayj6h3gnq")
const PLAYER_LASER = preload("uid://bsjnopnp5qi12")
const TIE_LASER = preload("uid://b4dat3awj1crm")
const ASTEROID = preload("uid://cfhqha2dcakb")
const TIE_FIGHTER = preload("uid://clbsg6ai2sfmg")

enum SceneNames { impactFlash }
enum LaserTypes { playerLaser, tieLaser }

const scenesDictionary: Dictionary[int, PackedScene] = {
	SceneNames.impactFlash: IMPACT_FLASH
}

func _ready() -> void:
	playerLaserPool = laserPool.new(15 , PLAYER_LASER, self, "PlayerLaser")
	tieLaserPool = laserPool.new(40, TIE_LASER, self, "TieLaser")
	
	SignalHub.on_CreateOneOff.connect(on_CreateOneOff)
	SignalHub.on_CreateLaser.connect(on_CreateLaser)
	SignalHub.on_CreatePackedScene.connect(on_create_packed_scene)


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
		LaserTypes.tieLaser: tieLaserPool.activateNextScene(pTr)

func spawnEnemies(scene: PackedScene, waitTime: float, spawnRangeX: Vector2,
	spawnRangeY: Vector2, countRange: Vector2i, timer: Timer) -> void:
	if !enabled:
		return
	var randX: float = randf_range(spawnRangeX.x, spawnRangeX.y)
	var randY: float = randf_range(spawnRangeX.x, spawnRangeX.y)
	var np: Vector3 = Vector3(randX, randY, global_position.z)
	
	for i in randf_range(countRange.x, countRange.y):
		var enemy: Node3D = scene.instantiate()
		#add_child(enemy)
		#enemy.global_position = np
		call_deferred("add_with_position", enemy, np)
		await get_tree().create_timer(waitTime, false).timeout
	
	timer.start()

func _on_tie_timer_timeout() -> void:
	spawnEnemies(TIE_FIGHTER, 1.5, x_range, y_range, Vector2i(3, 6), tie_timer)


func _on_asteroid_timer_timeout() -> void:
	spawnEnemies(ASTEROID, 2.5, x_range, y_range, Vector2i(1, 3), asteroid_timer)
