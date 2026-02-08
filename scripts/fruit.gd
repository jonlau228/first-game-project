extends Area2D

var score_value: int = 10
var pickup_sfx: AudioStream = preload("res://sounds/sfx_coin.ogg")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		GameManager.add_score(score_value)
		GameManager.play_sfx(pickup_sfx)
		queue_free()
