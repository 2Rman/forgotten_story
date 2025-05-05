class_name Player extends CharacterBody2D


const SPEED = 80.0
const JUMP_VELOCITY = -240.0

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var pause_menu_node: Control = $Camera2D/CenterContainer/PauseMenu
@onready var death_menu_node: Control = $Camera2D/CenterContainer/DeathMenu
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var steps: AudioStreamPlayer = $Sounds/Steps
@onready var audio_main_theme: AudioStreamPlayer = $"../AudioStreamPlayer"
@onready var death: AudioStreamPlayer = $Sounds/Death

var is_dead: bool = false
var is_paused: bool = false

func _ready() -> void:
	AudioServer.set_bus_bypass_effects(1, true)
	pause_menu()
	dead_menu()

func _physics_process(delta: float) -> void:
	
	if is_dead:
		audio_main_theme.stop()
		animation_player.play("death")
		death_camera()
		await animation_player.animation_finished
		dead_menu()
		#queue_free()
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		animation_player.play("fall")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("jump")

	var direction := Input.get_axis("left", "right")
	
	if direction == -1:
		animation.flip_h = true
	elif direction == 1:
		animation.flip_h = false
			
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation_player.play("move")
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			animation_player.play("idle")
	
	if Input.is_action_just_pressed("esc"):
		pause_menu()

	move_and_slide()
	
func _set_light_position() -> void:
	if self.has_node("PointLight2D"):
		var light = self.get_node("PointLight2D")
		light.name = "point_light_2d"
		light.position = Vector2(0, 0)
		
func _hit_enemy() -> void:
	velocity.y = -200

func _on_killbox_area_body_entered(body: Node2D) -> void:
	if body is Enemy:
		is_dead = true
		
func death_camera():
	if camera_2d.zoom > Vector2(4.5, 4.5):
		camera_2d.zoom -= Vector2(0.01, 0.01)

func pause_menu():
	if is_paused:
		pause_menu_node.show()
		Engine.time_scale = 0
	else:
		pause_menu_node.hide()
		Engine.time_scale = 1
	is_paused = !is_paused
	
func dead_menu():
	if is_dead:
		death_menu_node.show()
		Engine.time_scale = 0
	else:
		death_menu_node.hide()
		Engine.time_scale = 1

#ВКЛючение эффекта ревера
func _on_reverb_zone_entered():
	var tween = create_tween()
	var effect = AudioServer.get_bus_effect(1, 0)
	tween.tween_property(effect, "wet", 0.3, 0.2)
	await tween.finished
	AudioServer.set_bus_bypass_effects(1, false)
#ВЫКЛючение эффекта ревера
func _on_reverb_zone_exited():
	var tween = create_tween()
	var effect = AudioServer.get_bus_effect(1, 0)
	tween.tween_property(effect, "wet", 0.0, 0.2)
	await tween.finished
	AudioServer.set_bus_bypass_effects(1, true)
