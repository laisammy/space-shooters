extends GPUParticles3D

@export var oneOff: bool = true

@onready var impact_sound: AudioStreamPlayer3D = $impactSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if oneOff:
		bang()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func bang() -> void:
	impact_sound.play()
	emitting = true
	if oneOff:
		await impact_sound.finished
		queue_free()
	
