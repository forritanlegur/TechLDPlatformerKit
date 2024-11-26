extends Area3D

@export var platform : Node3D 
@export var platform_move_speed : float = 2.0  

var target_position : Vector3 = Vector3.ZERO 
# keeping the platform's original position so it can go back
var initial_position : Vector3 = Vector3.ZERO  

# Animation things
@export var animation_player: AnimationPlayer
var button_state : bool = false

func _ready():
	
	initial_position = platform.position
	target_position = initial_position
	
	# Connect the signals, worst part of godot
	body_entered.connect(self._on_body_entered)
	body_exited.connect(self._on_body_exited)

func _on_body_entered(body):
	print("Body entered: ", body.name)
	animation_player.play("toggle-on", -1, 10.0) 

	# checking if the body is part of the "snowballs" group, which holds weight information.
	if body.is_in_group("snowballs"):
		var snowball_weight = body.snowballWeight  
		print("Snowball entered with weight: ", snowball_weight)

		# moving platform position based on weight, the heavier weight the higher the platform will go. 
		target_position.y = snowball_weight * 0.1 

		# now the platform will move smoothly to the target position
		print("Target position set to: ", target_position)

func _on_body_exited(body):
	# Check if the body that left is a snowball
	if body.is_in_group("snowballs"):
		print("Snowball exited: ", body.name)
		animation_player.play("toggle-off", -1, 10.0)  

		
		target_position = initial_position
		print("Target position reset to: ", target_position)
	else:
		animation_player.play("toggle-off", -1, 10.0)

func _process(delta):
	# smooth lerping 
	platform.position = platform.position.lerp(target_position, platform_move_speed * delta)
