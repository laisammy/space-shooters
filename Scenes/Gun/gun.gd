extends Node3D

class_name gun

const gunFlash = preload("uid://d1d013gejgyay")

@export var debounce: float = 0.2
@export var muzzles: Array[Node3D]
@export var soundEffect: AudioStream

@onready var effect: AudioStreamPlayer3D = $effect

var gunFlashes: Array[GPUParticles3D]

var timer: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	effect.stream = soundEffect
	for m in muzzles:
		var gf: GPUParticles3D = gunFlash.instantiate()
		m.add_child(gf)
		gunFlashes.append(gf)
		
func shoot() -> void:
	if timer > debounce:
		effect.play()
		for gf in gunFlashes:
			gf.emitting = true
		timer = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
