extends Resource

class_name enemyBehaviour

@export var speed: float = 40.0
@export var engineSoundDistance: float = 50.0

var playerRef: LinkPlayer
var nearPlayer: bool = false


var owner: tieFighter:
	set(value): owner = value
	
func setup(pOwner: tieFighter) -> void:
	owner = pOwner
	playerRef = owner.player_ref
	
func update(delta: float) -> void:
	owner.translate(Vector3.FORWARD * speed * delta)
	if !nearPlayer and playerRef.player_less_than_distance(owner.global_position, engineSoundDistance):
		owner.engine_sound.play()
		nearPlayer = true
