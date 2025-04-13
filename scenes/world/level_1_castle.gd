extends Node2D

@onready var parallax_layer: ParallaxLayer = $ParallaxBackground/ParallaxLayer

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	parallax_layer.motion_offset.x -= 5 * delta
