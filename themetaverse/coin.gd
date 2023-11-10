extends MeshInstance3D

var time_acc = 0
var height = position.y
var gravity:Vector3=Vector3(0, 9.8, 0)
var velocity:Vector3
	
func _ready():
	var t = sqrt(height / (gravity.y * 0.5))
	var s = t * gravity.y
	print("Predicted Time: " + str(t))
	print("Predicted Speed: " + str(s))
	pass
	
func _physics_process(delta):	
	print(position.y)
	if position.y > 0:
		velocity = velocity - gravity * delta
		position = position + velocity * delta
		time_acc += delta
	else:
		print("time taken" + str(time_acc))
		print("final velocity" + str(velocity))
		
	
	
