extends Node3D

@onready var player:RigidBody3D = $"../../.."

@onready var flames:GPUParticles3D = $GPUParticles3D
@onready var audio:AudioStreamPlayer3D = $AudioStreamPlayer3D

@export var power = 100 

@export var trigger = 0.0

func _ready():
	pass

var lerped_trigger = 0.0

func _physics_process(delta):
	lerped_trigger = lerp(lerped_trigger, trigger, delta)
	if lerped_trigger > 0:
		if not audio.playing:
			audio.play()					
		audio.volume_db = remap(lerped_trigger, 0, 1, -80, 80)
		var force = - global_transform.basis.y * power * trigger
		player.apply_force(-force, Vector3.ZERO)
		flames.emitting = true
		flames.amount = max(1000 * trigger, 1)
	else:
		flames.emitting = false
		audio.stop()

func _on_xr_controller_3d_input_float_changed(name, value):
	if name == "trigger":
		trigger =  value
#	
	pass # Replace with function body.


