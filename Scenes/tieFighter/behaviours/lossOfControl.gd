extends enemyBehaviour

class_name lossOfControl

@export var lostControlDistance: float = 50.0
@export var lostControlSpeed: float = 25.0
@export var playerReachedDistance: float = 5.0
@export var spinSpeed: float = 8.0

const _384472__BROKEN_TIE = preload("uid://cyvtxvde2oedk")

var lostControl: bool = false
var pastPlayer: bool = false

func setup(pOwner: tieFighter) -> void:
	super(pOwner)
	owner.engine_sound.stream = _384472__BROKEN_TIE

func update(delta: float) -> void:
	var playerPos: Vector3 = playerRef.player_pos
	var zDist: float = abs(playerPos.z - owner.global_position.z)
	
	if zDist < playerReachedDistance:
		pastPlayer = true
		
	if !lostControl and zDist < lostControlDistance:
		lostControl = true
		speed = lostControlSpeed
		
	if lostControl:
		if !pastPlayer:
			owner.look_at(playerRef.player_pos)
		owner.modelMesh.rotate_y(spinSpeed * delta)
		owner.modelMesh.rotate_z(spinSpeed * delta)
		
	super(delta)
