extends Area3D

class_name laser

@export var damage: int = 10
@export var speed: float = 80.0

@onready var impact_point: Marker3D = $impactPoint

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getDamage() -> int:
	return damage
	
func _physics_process(delta: float) -> void:
	translate(Vector3.FORWARD * speed * delta)

func blowUp() -> void:
	SignalHub.emit_CreateOneOff(impact_point.global_position, Spawner.SceneNames.impactFlash)
	queue_free()

func _on_area_entered(area: Area3D) -> void:
	blowUp()
	print("playerLaser: _on_area_entered")


func _on_body_entered(body: Node3D) -> void:
	blowUp()
	print("playerLaser: _on_body_entered")
