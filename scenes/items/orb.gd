extends Area2D
class_name Orb

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		audio_stream_player_2d.stop()
		audio_stream_player.play()
		
		animated_sprite_2d.play("Collect")
		animated_sprite_2d.offset = Vector2(2, 20)
		
		point_light_2d.reparent(body)
		body._set_light_position()
		
		Globals.orbs_collected += 1
		
		await animated_sprite_2d.animation_finished
		
		queue_free()
