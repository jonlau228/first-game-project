extends Node2D

const SPEED = 100

var direction: int = 1

@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	area_2d.body_entered.connect(_on_area_2d_body_entered)

func _process(delta: float) -> void:
	if ray_cast_2d_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = false
	if ray_cast_2d_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = true
	
	position.x += direction * SPEED * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	var character := body as CharacterBody2D
	
	if character and character.is_in_group("Player"):
		area_2d.set_deferred("monitoring", false)
		character.velocity = Vector2(character.velocity.x, -400.0)
		await get_tree().create_timer(0.3).timeout
		queue_free()
