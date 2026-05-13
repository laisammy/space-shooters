@tool
extends Area3D

class_name hitBox

signal died

@export var shapeResource: Shape3D
@export var startHealth: int = 100
@export var explosionEffect: PackedScene
@export var explosionScene: PackedScene

@onready var collision_shape_3d: CollisionShape3D = $collisionShape3d

var currentHealth: int = 0
var dead: bool = false

func updateComponents() -> void:
	collision_shape_3d.shape = shapeResource
	
func _notification(what: int) -> void:
	if what == NOTIFICATION_EDITOR_POST_SAVE:
		updateComponents()

func _ready() -> void:
	currentHealth = startHealth
	updateComponents()

func disable() -> void:
	SpaceUtils.toggle_area3d(self, false)

func takeDamage(v: int) -> void:
	if dead:
		return
	currentHealth -= v
	print(currentHealth)
	if currentHealth <= 0:
		blowUp()
		die()
		
func die() -> void:
	dead = true
	died.emit()
	disable()
	
func blowUp() -> void:
	if explosionEffect:
		SignalHub.emit_CreatePackedScene(global_transform, explosionEffect)
	if explosionScene:
			SignalHub.emit_CreatePackedScene(global_transform, explosionScene)

func _on_area_entered(area: Area3D) -> void:
	if area is laser:
		print("_on_area_entered: Laser")
		takeDamage(area.getDamage())
