extends Camera3D

@export var offset: Vector3 = Vector3(0, 6, 15)
@export var cameraFollowSpeed: Vector2 = Vector2(18.0, 26.0)

@onready var player_ref: LinkPlayer = $PlayerRef
	
func _physics_process(delta: float) -> void:
	#global_position = player_ref.player_pos + offset
	var targetPosition = player_ref.player_pos + offset
	var xDelta: float = abs(targetPosition.x - global_position.x)
	var yDelta: float = abs(targetPosition.y - global_position.y)
	var speed: float = cameraFollowSpeed.x if xDelta > yDelta else cameraFollowSpeed.y
	
	global_position = global_position.move_toward(targetPosition, speed * delta)
