extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var point_light_2d: PointLight2D = $PointLight2D

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		animated_sprite_2d.play("Collect")
		animated_sprite_2d.offset = Vector2(2, 20)
		await animated_sprite_2d.animation_finished
		queue_free()
	pass
