extends Control

@onready var label_fire: Label = $VBoxContainer/HBoxContainer/FireCont/Label
@onready var label_nature: Label = $VBoxContainer/HBoxContainer/NatureCont/Label
@onready var label_death: Label = $VBoxContainer/HBoxContainer/DeathCont/Label
@onready var label_holy: Label = $VBoxContainer/HBoxContainer/HolyCont/Label

func _ready() -> void:
	label_fire.text = str(Globals.fire_orbs)
	label_death.text = str(Globals.death_orbs)
	label_nature.text = str(Globals.nature_orbs)
	label_holy.text = str(Globals.holy_orbs)

func _on_player_orb_collected() -> void:
	label_fire.text = str(Globals.fire_orbs)
	label_death.text = str(Globals.death_orbs)
	label_nature.text = str(Globals.nature_orbs)
	label_holy.text = str(Globals.holy_orbs)
