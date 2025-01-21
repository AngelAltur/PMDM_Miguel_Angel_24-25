extends Area2D

signal ball_entered  

func _on_Area2D_body_entered(body: Node) -> void:
	
	if body is CharacterBody2D:
		emit_signal("ball_entered")  
