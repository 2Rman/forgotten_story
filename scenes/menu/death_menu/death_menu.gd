extends Control

@onready var button: AudioStreamPlayer = $Button

func _on_try_again_pressed() -> void:
	button.play()
	Globals.is_dead = false
	get_tree().change_scene_to_file("res://scenes/world/world_1.tscn")


func _on_end_adventure_pressed() -> void:
	button.play()
	Globals.is_dead = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu/main_menu.tscn")
