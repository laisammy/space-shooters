class_name laserPool

var scenesList: Array[laser]
var container: Node3D
var packedScene: PackedScene
var namePrefix: String

func _init(_startScenes: int, _packed: PackedScene, _container: Node3D, _namePrefix: String) -> void:
	container = _container
	namePrefix = _namePrefix
	packedScene = _packed
	for i in range(_startScenes):
		addNewScene()
		
func addNewScene() -> laser:
	var newScene: laser = packedScene.instantiate()
	if namePrefix != "":
		newScene.name = "%s_%d" % [namePrefix, (scenesList.size() + 1)]
	container.add_child(newScene)
	scenesList.append(newScene)
	print("addNewScenes() ", newScene.name, "current size: ", scenesList.size())
	return newScene

func activateNextScene(pTr: Transform3D) -> void:
	for i in range(scenesList.size()):
		var scene: laser = scenesList[i]
		if !scene.visible:
			scene.start(pTr)
			print("Re-using: ", scene.name)
			return
	var newScene: laser = addNewScene()
	newScene.start(pTr)
