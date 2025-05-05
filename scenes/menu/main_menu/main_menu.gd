extends Control

@onready var parallax_clouds: ParallaxLayer = $MarginContainer/CenterContainer/ParallaxBackground/ParallaxClouds
@onready var main_menu: Control = $"."
@onready var audio_player: AudioStreamPlayer = $MainTheme
@onready var button: AudioStreamPlayer = $Button

func _ready() -> void:
	Engine.time_scale = 1
	audio_player.play()

func _process(delta: float) -> void:
	parallax_clouds.motion_offset.x += 20 * delta

func _on_button_start_pressed() -> void:
	button.play()
	audio_player.stop()
	get_tree().change_scene_to_file("res://scenes/world/world_1.tscn")


func _on_button_exit_pressed() -> void:
	button.play()
	get_tree().quit()
