extends Area2D
class_name Orb

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var point_light_2d: PointLight2D = $PointLight2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.on_orb_collected(self)
		#change_stat()
		
		audio_stream_player_2d.stop()
		audio_stream_player.play()
		
		animated_sprite_2d.play("Collect")
		animated_sprite_2d.offset = Vector2(2, 20)
		
		await animated_sprite_2d.animation_finished
		
		queue_free()

#func change_stat():
	#pass
