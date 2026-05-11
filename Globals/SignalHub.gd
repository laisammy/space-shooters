extends Node

signal on_CreateOneOff(pPos: Vector3, sceneName: Spawner.SceneNames)
signal on_CreateLaser(pTr: Transform3D, laserType: Spawner.LaserTypes)

func emit_CreateOneOff(pPos: Vector3, sceneName: Spawner.SceneNames) -> void:
	on_CreateOneOff.emit(pPos, sceneName)
	print("emit_CreateOneOff")

func emit_CreateLaser(pTr: Transform3D, laserType: Spawner.LaserTypes) -> void:
	on_CreateLaser.emit(pTr, laserType)
