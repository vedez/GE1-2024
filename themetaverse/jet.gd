extends Node3D

@onready var player:RigidBody3D = $"../../.."

@export var power = 100 

func _on_xr_controller_3d_input_float_changed(name, value):
	print(name + " " + str(value))
	
	var t = get_physics_process_delta_time()
	var force = global_transform.basis.z * power * t
	
	player.apply_force(force, Vector3.ZERO)
	pass # Replace with function body.
