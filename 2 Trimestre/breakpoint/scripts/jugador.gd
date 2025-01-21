extends CharacterBody2D

var speed = 500

func _process(delta):
	velocity.x = 0
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed

	move_and_slide()
