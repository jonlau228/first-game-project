extends Node2D

var jump_height: float = 150.0
var jump_speed: float = 500.0
var jump_interval: float = 1.0 
var vertical_velocity: float = 0.0
var gravity: float = 1200.0
var ground_y: float
var timer: float = 0.0

@onready var ray_cast_2d_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_2d_left: RayCast2D = $RayCast2DLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	ground_y = position.y

func _process(delta: float) -> void:
	if position.y < ground_y:
		vertical_velocity += gravity * delta
	else:
		position.y = ground_y
		vertical_velocity = 0
		
		timer += delta
		if timer >= jump_interval:
			jump()
			timer = 0.0

	position.y += vertical_velocity * delta

func jump() -> void:
	vertical_velocity = -jump_speed
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	var character := body as CharacterBody2D
	
	if character and character.is_in_group("Player"):
		area_2d.set_deferred("monitoring", false)
		character.velocity = Vector2(character.velocity.x, -400.0)
		await get_tree().create_timer(0.3).timeout
		queue_free()
