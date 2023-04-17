extends CharacterBody3D

signal squashed

@export var min_speed = 10
@export var max_speed = 18

func _physics_process(delta):
	move_and_slide()
	
func initialize(start_position, player_position):
	# Place mob at start_position rotate toward player
	look_at_from_position(start_position, player_position, Vector3.UP)
	# Rotate left or right at a random angle as not 
	# to collide with the player
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	# Rotate velocity to move in direction the 
	# mob is looking
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
	
func squash():
	squashed.emit()
	queue_free()
