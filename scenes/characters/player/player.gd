class_name Player extends CharacterBody2D

signal orb_collected()

const SPEED = 80.0
const JUMP_VELOCITY = -260.0

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var steps: AudioStreamPlayer = $Sounds/Steps
@onready var audio_main_theme: AudioStreamPlayer = $"../AudioStreamPlayer"
@onready var death: AudioStreamPlayer = $Sounds/Death
@onready var world_1: Node2D = $".."
@onready var wall_collider: RayCast2D = $WallCollider
@onready var floor_collider: RayCast2D = $FloorCollider
@onready var holy_light: PointLight2D = $Wings/HolyLight
@onready var wings: AnimatedSprite2D = $Wings

var fireball_scene_resource = preload("res://scenes/items/fireball/fireball.tscn")
var is_paused: bool = false
var direction
var last_direction
var is_killed_by_enemy := false
var is_killed_by_falling := false
var is_dying := false
var is_resurecting := false

var is_playing_death_anim := false

func _ready() -> void:
	AudioServer.set_bus_bypass_effects(1, true)
	holy_light.hide()

func _physics_process(delta: float) -> void:
	if Globals.is_dead and Globals.holy_orbs == 0:
		audio_main_theme.stop()
		animation_player.play("death")
		death_camera()
		await animation_player.animation_finished
		world_1.dead_menu()
	elif Globals.is_dead and Globals.holy_orbs > 0:
		audio_main_theme.set_stream_paused(true)
		if is_killed_by_enemy:
			
			if is_dying: return
				
			is_dying = true
			
			holy_light.show()
			animation_player.play("raise")
			
			await get_tree().create_timer(2).timeout
			wings.play("wings")
			
			await animation_player.animation_finished
			Globals.is_dead = false
			Globals.holy_orbs -= 1
			Signals.holy_orb_used.emit()
			
			is_dying = false
			is_killed_by_enemy = false
			holy_light.hide()
			
		if is_killed_by_falling:
			print("by falling")
			if is_dying:
				animation.hide()
				animation_player.play("death")
				await animation_player.animation_finished
				
				is_dying = false
				return
			
			if wall_collider.is_colliding() and !floor_collider.is_colliding():
				velocity = Vector2(0, -100) * SPEED * delta
			elif !wall_collider.is_colliding() and !floor_collider.is_colliding():
				velocity = Vector2(-100, 0) * SPEED * delta
			elif floor_collider.is_colliding():
				is_resurecting = false
				animation.show()
				print("stop here")
				holy_light.show()
				
				animation_player.play("resurection")
				wings.play("wings")
			
				await animation_player.animation_finished
				holy_light.hide()
				if is_resurecting: return
				
				is_resurecting = true

				Globals.is_dead = false
				is_killed_by_falling = false
				
				Globals.holy_orbs -= 1
				Signals.holy_orb_used.emit()
				
		audio_main_theme.set_stream_paused(false)
	
	
	if Input.is_action_just_pressed("use_orb"):
		await orb_using()
	
	if not is_on_floor() and Globals.is_dead == false:
		velocity += get_gravity() * delta
		animation_player.play("fall")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_player.play("jump")

	direction = Input.get_axis("left", "right")
	
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

	move_and_slide()
	
	
func orb_using():
	match Globals.selected_orb:
		Globals.ORBS.FIRE:
			if Globals.fire_orbs > 0:
				var fireball = fireball_scene_resource.instantiate()
				world_1.add_child(fireball)
				fireball.global_position = global_position
				fireball.direction = Vector2(1, 0) if animation.flip_h == false else Vector2(-1, 0)
				velocity.x = 0
				set_physics_process(false)
				animation_player.play("cast_fire")
				await animation_player.animation_finished
				set_physics_process(true)
		Globals.ORBS.NATURE:
			if Globals.nature_orbs > 0:
				velocity.x = 0
				set_physics_process(false)
				animation_player.play("cast_nature")
				await animation_player.animation_finished
				set_physics_process(true)
		Globals.ORBS.DEATH:
			if Globals.death_orbs > 0:
				velocity.x = 0
				set_physics_process(false)
				animation_player.play("cast_death")
				await animation_player.animation_finished
				set_physics_process(true)

		
func _hit_enemy() -> void:
	velocity.y = -200

func _on_killbox_area_body_entered(body: Node2D) -> void:
	if body is Enemy:
		is_killed_by_enemy = true
		Globals.is_dead = true
		
func death_camera():
	if camera_2d.zoom > Vector2(4.5, 4.5):
		camera_2d.zoom -= Vector2(0.01, 0.01)


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
	
func on_orb_collected(object: Orb):
	if object is FireOrb: 
		Globals.fire_orbs += 1
	elif object is NatureOrb:
		Globals.nature_orbs += 1
	elif object is DeathOrb:
		Globals.death_orbs += 1
	elif object is HolyOrb:
		Globals.holy_orbs += 1
	orb_collected.emit()
	pass

func handle_death():
	audio_main_theme.stop()
	animation_player.play("death")
	death_camera()
	await animation_player.animation_finished
	world_1.dead_menu()
#
#func killed_by_falling():
	#print("killed by falling")
	#pass
