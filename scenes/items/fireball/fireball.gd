extends CharacterBody2D

const MAX_DISTANCE := 300.0

var speed := 130
var direction: Vector2
var distance := 0.0
var is_collided := false

@onready var raycast: RayCast2D = $RayCast2D
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var cast: AudioStreamPlayer = $cast
@onready var fly: AudioStreamPlayer2D = $fly
@onready var collapse: AudioStreamPlayer2D = $collapse

@export var velo = velocity
signal target_hit(object)

func _ready() -> void:
	animation.play("start")
	cast.play()

func _physics_process(delta: float) -> void:
	
	if animation.animation == "start":
		await  animation.animation_finished
		animation.play("fly")
		fly.play()
		return
	
	if direction.x > 0:
		animation.flip_h = false
		raycast.target_position = Vector2(3, 0)
	elif direction.x < 0:
		animation.flip_h = true
		raycast.target_position = Vector2(-3, 0)
		
	if raycast.is_colliding():
		is_collided = true
		collapse.play()
	
	if is_collided:
		if raycast.is_colliding():
			var object = raycast.get_collider()
			if object is TileMapLayer:
				is_collided = true
				animation.play("finish")
				raycast.set_enabled(false)
				await animation.animation_finished
				queue_free()
			elif object is Enemy:
				object.is_dead = true
				is_collided = true
				animation.play("finish")
				raycast.set_enabled(false)
				await animation.animation_finished
				queue_free()
				
	else:
		position += direction * speed * delta
		distance += speed * delta 
		if distance > MAX_DISTANCE:
			queue_free()
			return
