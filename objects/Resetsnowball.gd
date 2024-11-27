extends Area3D



func _ready() -> void:
	body_entered.connect(self._on_body_entered)
	body_exited.connect(self._on_body_exited)


func _on_body_entered(body):
	print("Body entered RESETTER: ", body.name)

	# checking if the body is part of the "snowballs" 
	if body.is_in_group("snowballs"):
		#just calling a function of the snowballs that will reset the size. 
		body.resetSize()


func _on_body_exited(body):
	# Check if the body that left is a snowball
	if body.is_in_group("snowballs"):
		print("Snowball exited resetter: ", body.name)
