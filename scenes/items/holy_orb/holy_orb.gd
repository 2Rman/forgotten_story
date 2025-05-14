extends Orb
class_name HolyOrb

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		#change_stat()
		
		collision_shape_2d.queue_free()
		
		audio_stream_player_2d.stop()
		audio_stream_player.play()
		
		animated_sprite_2d.play("Collect")

		await animated_sprite_2d.animation_finished
		
		queue_free()

#func change_stat():
	#Globals.holy_orbs += 1
