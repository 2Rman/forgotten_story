extends Orb

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		audio_stream_player_2d.stop()
		audio_stream_player.play()
		
		animated_sprite_2d.play("Collect")
		animated_sprite_2d.offset = Vector2(2, 20)

		Globals.orbs_collected += 1
		
		await animated_sprite_2d.animation_finished
		await audio_stream_player.finished
		
		queue_free()
