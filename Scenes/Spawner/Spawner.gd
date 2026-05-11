extends Node3D


class_name Spawner


@export var x_range: Vector2 = Vector2(-20, 20)
@export var y_range: Vector2 = Vector2(-20, 20)
@export var enabled: bool = true
@onready var tie_timer: Timer = $TieTimer
@onready var asteroid_timer: Timer = $AsteroidTimer

const IMPACT_FLASH = preload("uid://b2qkayj6h3gnq")

enum SceneNames { impactFlash }

const scenesDictionary: Dictionary[int, PackedScene] = {
	SceneNames.impactFlash: IMPACT_FLASH
}

func _ready() -> void:
	SignalHub.on_CreateOneOff.connect(on_CreateOneOff)


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

func _on_tie_timer_timeout() -> void:
	pass


func _on_asteroid_timer_timeout() -> void:
	pass
