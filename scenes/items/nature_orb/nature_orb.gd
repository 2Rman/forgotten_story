extends Orb
class_name NatureOrb

func _process(delta: float) -> void:
	pass

#func _on_body_entered(body: Node2D) -> void:
	#if body.name == "Player":
		#collision_shape_2d.queue_free()
		#
		#audio_stream_player_2d.stop()
		#audio_stream_player.play()
		#
		#animated_sprite_2d.play("Collect")
		#animated_sprite_2d.offset = Vector2(2, 20)
	#
		#await animated_sprite_2d.animation_finished
		#await audio_stream_player.finished
		#queue_free()

#func change_stat():
	#emit_signal("orb_collected", self)
	#Globals.nature_orbs += 1
