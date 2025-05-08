extends Node2D

@onready var parallax_layer: ParallaxLayer = $ParallaxBackground/ParallaxLayer
@onready var reverb_area: Area2D = $AudioZones/ReverbArea

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	parallax_layer.motion_offset.x -= 5 * delta



func _on_reverb_area_body_entered(body: Node2D) -> void:
	if body is Player or body is Enemy:
		body._on_reverb_zone_entered()
		print(body)

func _on_reverb_area_body_exited(body: Node2D) -> void:
	if body is Player or body is Enemy:
		body._on_reverb_zone_exited()


func _on_area_dead_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.is_dead = true
