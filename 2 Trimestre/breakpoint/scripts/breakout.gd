extends Node2D

@onready var ball = $Ball
@onready var player = $Player

func _ready():
	player.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - 50)

func _process(delta):
	if ball.position.y > get_viewport_rect().size.y:
		reset_ball()

func reset_ball():
	ball.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y / 2)
	ball.ball_velocity = Vector2(300, 300).rotated(randf() * 2 * PI)
