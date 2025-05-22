extends Node2D

@onready var pause_menu_node: Control = $CanvasLayer/PauseMenu
@onready var death_menu_node: Control = $CanvasLayer/death_menu
@onready var ui: Control = $CanvasLayer/UI

var is_paused := false

func _ready() -> void:
	pause_menu()
	dead_menu()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		pause_menu()
func pause_menu():
	if is_paused:
		pause_menu_node.show()
		Engine.time_scale = 0
	else:
		pause_menu_node.hide()
		Engine.time_scale = 1
	is_paused = !is_paused

func dead_menu():
	if Globals.is_dead:
		death_menu_node.show()
		Engine.time_scale = 0
	else:
		death_menu_node.hide()
		Engine.time_scale = 1
