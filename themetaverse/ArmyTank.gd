extends CharacterBody3D

@export var speed = 10.0
@export var rotSpeed = 5.0
@export var fireRate = 5;

@export var bulletPrefab:PackedScene

@export var can_fire = true; 

@export var AITank: Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _drawGizmos():

	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.connect("timeout", Callable(self, "enableFire"))
		
	pass # Replace with function body.
	
func enableFire():
	can_fire = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):		
	
	checkIfAIinRange()
	
	# rotate_y(0.1)
	var turn = Input.get_axis("turn_left", "turn_right")
	
	if abs(turn) > 0:     
		# rotate()
		rotation.y -= rotSpeed * delta * turn
	
	# rotate_y(0.1)
	# rotate_x(0.1)
	var move = Input.get_axis("move_for", "move_back")
	if abs(move) > 0:     
		# set_velocity(- transform.basis.z * speed * move)
		# move_and_slide()
		translate(Vector3.FORWARD * speed * move * delta)
		# move_and_collide()
		
		
	if can_fire and Input.is_action_pressed("ui_select"):
		var bullet = bulletPrefab.instantiate()
		$"..".add_child(bullet)
		bullet.rotation = rotation
		bullet.global_transform.origin = $CharacterBody3D/Turret/bulletSpawn.global_transform.origin				
		can_fire = false
		$Timer.start(1.0 / fireRate)

		
	_drawGizmos()
	
func checkIfAIinRange():
	var player_to_ai_direction = (AITank.transform.origin - global_transform.origin).normalized()
	var player_to_ai_NoNormalize = (AITank.transform.origin - global_transform.origin)

	var player_forward_direction = global_transform.basis.z.normalized()
	var angle_to_ai = player_forward_direction.angle_to(player_to_ai_direction)

	if angle_to_ai <= deg_to_rad(45.0):
		print("AI Tank is in front")
	else:
		print("AI Tank is behind")

	var distance_to_ai = player_to_ai_NoNormalize.length()

	if distance_to_ai < 10.0:
		print("AI Tank is in range")
		print(distance_to_ai)
	else:
		print("AI Tank is out of range")
		print(distance_to_ai)
		
