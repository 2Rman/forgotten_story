extends Enemy

@onready var timer: Timer = $Timer
@onready var killbox_area: Area2D = $KillboxArea
@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var audio_stream_player: AudioStreamPlayer = $Audio/AudioStreamPlayer
@onready var obstacle_controller: RayCast2D = $ObstacleController
@onready var floor_collider: RayCast2D = $FloorCollider

const SPEED = 50.0

var death_sound = preload("res://assets/sounds/enemy_death/puf.mp3")
var rand: RandomNumberGenerator
var direction = 0
var is_dead:= false

func _ready() -> void:
	rand = RandomNumberGenerator.new()
	audio_stream_player.stream = death_sound
	
func _physics_process(delta: float) -> void:
	if is_dead == true:
		animation_player.play("Death")
		await  animation_player.animation_finished
		queue_free()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if direction == -1:
		animation.flip_h = true
		obstacle_controller.target_position.x = -10
		floor_collider.position.x = -10
	elif direction == 1:
		animation.flip_h = false
		obstacle_controller.target_position.x = 10
		floor_collider.position.x = 10
		
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation_player.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation_player.play("Idle")
	
	if obstacle_controller.is_colliding() and obstacle_controller.get_collider() is TileMapLayer:
		velocity = Vector2(50, -170)
	
	if !floor_collider.is_colliding():
		direction = -direction
	
	move_and_slide()

func _on_timer_timeout() -> void:
	timer.wait_time = randf_range(0.5, 1)
	direction = rand.randi_range(-1, 1)

func _on_killbox_area_body_entered(body: Node2D) -> void:
	if body is Player:
		is_dead = true
		cpu_particles_2d.queue_free()
		killbox_area.queue_free()
		collision_shape.queue_free()
		body._hit_enemy()

func _on_reverb_zone_entered():
	pass
	#audio_stream_player.set_bus(AudioServer.get_bus_name(1))
	
	
func _on_reverb_zone_exited():
	pass
	#audio_stream_player.set_bus(AudioServer.get_bus_name(0))
	
