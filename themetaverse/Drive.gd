extends VehicleBody3D

func _physics_process(delta):
	var f = Input.get_axis("move_for", "move_back")
	engine_force = f * 100
	
	var t = Input.get_axis("turn_left", "turn_right")
	steering = t * 10
	
