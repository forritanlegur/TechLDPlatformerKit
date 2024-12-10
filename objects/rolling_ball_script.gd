extends RigidBody3D

# References to the CollisionShape3D and MeshInstance3D nodes
@onready var collision_shape = $CollisionShape3D
@onready var mesh_instance = $MeshInstance3D

# Maximum scale factor
var max_scale = 10.0
var min_scale = 0.5

var scale_speed = 0.1 

# ,min velocity for ball to grow. Currently when the ball is still it experiences a bit above zero.but underone.
var velocity_threshold = 1.0
var scale_increment = 0.08

# current scale 
@export var current_scale = min_scale

#The weight to be used by the scale
@export var snowballWeight = 1

func _ready():
	# Add this ball to the "snowballs" group
	add_to_group("snowballs")

func _process(delta):
	# get the current velocity of the RigidBody3D
	var velocity = linear_velocity.length()

	# if the velocity exceeds the threshold, increasescale 
	if velocity > velocity_threshold:
		current_scale += scale_increment * delta  # Gradually increase the scale over time

	# clamping
	current_scale = min(current_scale, max_scale)

	#apply the updated scale to the mesh and collision shape
	mesh_instance.scale = Vector3(current_scale, current_scale, current_scale)
	collision_shape.scale = Vector3(current_scale, current_scale, current_scale)

	#debugging to test some things
	#print_debug("current scale ", current_scale)
	#print_debug("current velocity ", velocity)
	
	#updating the weight and debugging it 
	snowballWeight = round(current_scale*10)
	#print_debug("the snowball is weighing : ", snowballWeight, " kgs")

func resetSize():
	#reset the size of the snowball back to normal
	print_debug("Snowball Size Reset!")
	mesh_instance.scale = Vector3(min_scale, min_scale, min_scale)
	collision_shape.scale = Vector3(min_scale, min_scale, min_scale)
	current_scale = min_scale
	snowballWeight = 1
