extends CharacterBody2D

var ball_velocity = Vector2(300, 300)

func _ready():
	set_process(true)

func _process(delta):
	var collision_info = move_and_collide(ball_velocity * delta)
	if collision_info:
		if abs(collision_info.normal.y) > 0.1:
			ball_velocity.y = -ball_velocity.y
		if abs(collision_info.normal.x) > 0.1:
			ball_velocity.x = -ball_velocity.x
	check_boundaries()

func check_boundaries():
	if position.x < 0 or position.x > get_viewport_rect().size.x:
		ball_velocity.x = -ball_velocity.x
	if position.y < 0:
		ball_velocity.y = -ball_velocity.y
