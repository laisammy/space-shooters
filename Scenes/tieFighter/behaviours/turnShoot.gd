extends enemyBehaviour

class_name turnShoot

@export var engageDistance: float = 100.0

var engaged: bool = false

func update(delta: float) -> void:
	if !engaged:
		if playerRef.player_less_than_distance(owner.global_position, engageDistance):
			engaged = true
			owner.look_at(playerRef.player_pos)
			owner.shootBurst()
	super(delta)
