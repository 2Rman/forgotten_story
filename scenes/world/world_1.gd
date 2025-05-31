extends Node2D

@onready var pause_menu_node: Control = $CanvasLayer/PauseMenu
@onready var death_menu_node: Control = $CanvasLayer/death_menu
@onready var ui: Control = $CanvasLayer/UI

var is_paused := false

func _ready() -> void:
	Signals.fire_colleced_first_time.connect(_on_fire_collected_first)
	Signals.nature_colleced_first_time.connect(_on_nature_collected_first)
	Signals.holy_colleced_first_time.connect(_on_holy_collected_first)
	Signals.death_colleced_first_time.connect(_on_death_collected_first)
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

func _on_fire_collected_first():
	print("fire lor")
	
func _on_nature_collected_first():
	print("nature lor")
	
func _on_holy_collected_first():
	print("holy lor")
	
func _on_death_collected_first():
	print("death lor")
