extends Node3D

var balls_group = "snowballs"

func _ready():
	# Print all nodes in the "snowballs" group
	var balls = get_tree().get_nodes_in_group(balls_group)
	for ball in balls:
		print(ball.name)  # This will print the name of each ball in the group
