extends Node3D

class_name shadedWall

@export var isY: bool = false

@onready var player_ref: LinkPlayer = $PlayerRef
@onready var wall_mesh: MeshInstance3D = $wallMesh

var maxDistance: float = 7.0
var distanceToPlayer: float = 0.0
var wallMaterial: ShaderMaterial

func _ready() -> void:
	wallMaterial = wall_mesh.material_override as ShaderMaterial
	
func _physics_process(_delta: float) -> void:
	if isY:
		distanceToPlayer = abs(player_ref.player_y - global_position.y)
	else:
		distanceToPlayer = abs(player_ref.player_x - global_position.x)
	var strength: float = clampf((maxDistance - distanceToPlayer) / maxDistance, 0.0, 1.0)
	wallMaterial.set_shader_parameter("Strength", strength)
