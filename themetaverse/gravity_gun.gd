extends Node3D

@export var hold_distance = 3
@export var maximum_velocity = 5;
@export var power_factor = 1;

var picked_up;

@export var camera_path:NodePath

@onready var camera:Node3D

@export var is_phis_gun:bool = false

func _ready():
	camera = get_node(camera_path)
	pass
	
func _physics_process(delta):
	var space_state = get_world_3d().direct_space_state
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if picked_up == null:
			var start = camera.global_position
			var end = camera.global_position - camera.global_transform.basis.z * 10000
			var query = PhysicsRayQueryParameters3D.create(start, end)
			
			var result = space_state.intersect_ray(query)
			if not result.is_empty():	
				var thing = result["collider"]

				if thing.name != "ground":
					picked_up = thing
					if is_phis_gun:			
						var to_target = picked_up.global_position - camera.global_position		
						hold_distance = to_target.length()
		else:
			print(picked_up.name)
			var hold_pos = camera.global_position - camera.global_transform.basis.z * hold_distance
			var to_hold_pos = hold_pos - picked_up.global_position
			# to_hold_pos = to_hold_pos.normalized()
			to_hold_pos *= power_factor
			to_hold_pos = to_hold_pos.limit_length(maximum_velocity)
			picked_up.linear_velocity = to_hold_pos
	else:
		picked_up = null
