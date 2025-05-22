extends CharacterBody2D

const MAX_DISTANCE := 300.0

var speed := 100
var direction: Vector2
var distance := 0.0

@onready var raycast: RayCast2D = $RayCast2D
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

@export var velo = velocity
signal target_hit(object)

func _ready() -> void:
	animation.play("start")

func _physics_process(delta: float) -> void:
	
	if animation.animation == "start":
		await  animation.animation_finished
		animation.play("fly")
		return
		
	position += direction * speed * delta
	
	if direction.x > 0:
		animation.flip_h = false
	elif direction.x < 0:
		animation.flip_h = true
	
	if direction.length() > 0:
		distance += speed * delta
		if raycast.is_colliding():
			var object = raycast.get_collider()
			
			#target_hit.emit(object)
			#if object is Enemy:
				#object.is_dead = true
				#print(object)
			#elif object is not TileMapLayer:
				#animation.play("finish")
				#queue_free()
			return
		if distance > MAX_DISTANCE:
			#target_hit.emit(null)
			queue_free()
			return
