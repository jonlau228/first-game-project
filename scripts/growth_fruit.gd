extends Area2D

var growth_factor: float = 1.5

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		enlarge_player(body)
		queue_free()

func enlarge_player(player: Node2D) -> void:
	player.scale *= Vector2(growth_factor, growth_factor)
