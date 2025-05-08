extends Control

@onready var menu = $"../.."
@onready var button: AudioStreamPlayer = $Button

func _on_resume_pressed() -> void:
	button.play()
	menu.pause_menu()

func _on_end_adventure_pressed() -> void:
	button.play()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu/main_menu.tscn")
