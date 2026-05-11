extends Node

signal on_CreateOneOff(pPos: Vector3, sceneName: Spawner.SceneNames)

func emit_CreateOneOff(pPos: Vector3, sceneName: Spawner.SceneNames) -> void:
	on_CreateOneOff.emit(pPos, sceneName)
	print("emit_CreateOneOff")
