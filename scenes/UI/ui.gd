extends Control

enum ORBS {FIRE, NATURE, DEATH, HOLY}

@onready var label_fire: Label = $VBoxContainer/HBoxContainer/FireCont/Label
@onready var label_nature: Label = $VBoxContainer/HBoxContainer/NatureCont/Label
@onready var label_death: Label = $VBoxContainer/HBoxContainer/DeathCont/Label
@onready var label_holy: Label = $VBoxContainer/HBoxContainer/HolyCont/Label

@onready var fire_anim: AnimatedSprite2D = $VBoxContainer/HBoxContainer/FireCont/fireAnim
@onready var nature_anim: AnimatedSprite2D = $VBoxContainer/HBoxContainer/NatureCont/natureAnim
@onready var death_anim: AnimatedSprite2D = $VBoxContainer/HBoxContainer/DeathCont/deathAnim
@onready var holy_anim: AnimatedSprite2D = $VBoxContainer/HBoxContainer/HolyCont/holyAnim

@onready var orb_area: Area2D = $"../../Player/OrbControlArea"

var selected_orb: int = 0

func _ready() -> void:
	label_fire.text = str(Globals.fire_orbs)
	label_death.text = str(Globals.death_orbs)
	label_nature.text = str(Globals.nature_orbs)
	label_holy.text = str(Globals.holy_orbs)
	
	fire_anim.play("Selected" if selected_orb == ORBS.FIRE else "NotSelected")
	nature_anim.play("NotSelected")
	death_anim.play("NotSelected")
	holy_anim.play("NotSelected")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("change_orb"):
		change_orb()
	
	if Input.is_action_just_pressed("use_orb"):
		use_orb()
	
	fire_anim.play("Selected" if selected_orb == ORBS.FIRE else "NotSelected")
	nature_anim.play("Selected" if selected_orb == ORBS.NATURE else "NotSelected")
	death_anim.play("Selected" if selected_orb == ORBS.DEATH else "NotSelected")
	
	holy_anim.play("Selected" if Globals.holy_orbs > 0 else "NotSelected")
	
func change_orb():
	selected_orb = wrapi(selected_orb + 1, 0, 3)
	
func use_orb():
	match selected_orb:
		ORBS.FIRE: fire_orb_using()
		ORBS.NATURE: nature_orb_using()
		ORBS.DEATH: death_orb_using()

func _on_player_orb_collected() -> void:
	label_fire.text = str(Globals.fire_orbs)
	label_death.text = str(Globals.death_orbs)
	label_nature.text = str(Globals.nature_orbs)
	label_holy.text = str(Globals.holy_orbs)

func fire_orb_using():
	pass

func nature_orb_using():
	print("nature")
	pass
	
func death_orb_using():
	if (orb_area.has_overlapping_bodies()):
		for one in orb_area.get_overlapping_bodies():
			one.is_dead = true
