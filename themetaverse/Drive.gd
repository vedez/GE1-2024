extends VehicleBody3D

var max_steer = 45
var power = 5000

func _physics_process(delta):
	
	var f = Input.get_axis("move_for", "move_back")
	
	engine_force = -f * power
	
	var t = Input.get_axis("turn_left", "turn_right")
	steering = lerp(steering, -t * deg_to_rad(max_steer), delta * 5)
	
