extends Node2D

@onready var parallax_layer: ParallaxLayer = $ParallaxBackground/ParallaxLayer
@onready var reverb_area: Area2D = $AudioZones/ReverbArea
@onready var moon_light: PointLight2D = $ParallaxBackground/ParallaxLayer4/Moon/PointLight2D

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	parallax_layer.motion_offset.x -= 5 * delta

func _on_reverb_area_body_entered(body: Node2D) -> void:
	if body is Player or body is Enemy:
		var tween = create_tween()
		tween.tween_property(moon_light, "energy", 0.5, 1)
		body._on_reverb_zone_entered()

func _on_reverb_area_body_exited(body: Node2D) -> void:
	if body is Player or body is Enemy:
		body._on_reverb_zone_exited()
		var tween = create_tween()
		tween.tween_property(moon_light, "energy", 2.0, 1)
		moon_light.energy = lerp(0.5, 3.0, 0.1)
	
func _on_area_dead_body_entered(body: Node2D) -> void:
	if body is Player:
		Globals.is_dead = true
		body.is_killed_by_falling = true
		body.is_dying = true
		
