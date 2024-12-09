extends CharacterBody3D


# Declare member variables here. Examples:
@export var speed = 10.0
# var a = 2
# var b = "text"

var forward

var noise:FastNoiseLite = FastNoiseLite.new()

func _ready():
	noise.seed = randi()
	noise.set_noise_type(FastNoiseLite.TYPE_PERLIN)
	
	get_node("AudioStreamPlayer3D").pitch_scale = randf_range(0.5, 1.0)

func destroy():
	get_parent().remove_child(self)
	
var t = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	# Local space forward
	var forward = Vector3.BACK	
	var v  = speed * forward * delta		
	
	# Transform to world space by multiplying by
	var q = global_transform.basis.get_rotation_quaternion() 
	v = q * v
	
	# This will also work, but it can also scale as the 3 x 3 matrix contains scale
	#v = global_transform.basis * v	 
	
	# Add a noise 
	var n = Vector3(noise.get_noise_1d(t), noise.get_noise_1d(t + 100),  0)
	n = q * n
	DebugDraw.draw_arrow_line(global_position, global_position + (n * 5), Color.RED, 0.1)
	DebugDraw.draw_arrow_line(global_position, global_position + (global_transform.basis.z), Color.BLUE, 0.1)
	# I think this should return true when a collision happens, but it doesnt
	# v += (n * delta)
	# var collision = move_and_collide(v)	
	# 
	global_position += (v + n * 0.1)
	#translate(v)
	# look_at(global_transform.origin - v, global_transform.basis.y)
	t += delta * 10

func _on_Timer_timeout():
	# destroy()
	pass # Replace with function body.
