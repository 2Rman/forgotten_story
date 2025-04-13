extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -240.0

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		animation.play("fall")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.play("jump")
		animation.get

	var direction := Input.get_axis("left", "right")
	
	if direction == -1:
		animation.flip_h = true
	elif direction == 1:
		animation.flip_h = false
			
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation.play("move")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animation.play("idle")

	move_and_slide()
