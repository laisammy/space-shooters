extends Area3D

class_name laser

const OFF_SCREEN: Vector3 = Vector3(0, 0, 200)

@export var damage: int = 10
@export var speed: float = 80.0

@onready var impact_point: Marker3D = $impactPoint
@onready var life_timer: LifeTimer = $LifeTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stop()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func getDamage() -> int:
	return damage
	
func _physics_process(delta: float) -> void:
	translate(Vector3.FORWARD * speed * delta)
	
func start(pTr: Transform3D) -> void:
	var bas: Basis = pTr.basis.orthonormalized()
	global_transform = Transform3D(bas, pTr.origin)
	
	SpaceUtils.toggle_area3d(self, true)
	set_physics_process(true)
	life_timer.start_timer()
	show()
	
func stop() -> void:
	global_position = OFF_SCREEN
	SpaceUtils.toggle_area3d(self, false)
	set_physics_process(false)
	hide()

func blowUp() -> void:
	SignalHub.emit_CreateOneOff(impact_point.global_position, Spawner.SceneNames.impactFlash)
	stop()

func _on_area_entered(area: Area3D) -> void:
	blowUp()
	print("playerLaser: _on_area_entered")


func _on_body_entered(body: Node3D) -> void:
	blowUp()
	print("playerLaser: _on_body_entered")


func _on_life_timer_time_out() -> void:
	print("Laser: _on_life_timer_time_out")
	stop()
	
