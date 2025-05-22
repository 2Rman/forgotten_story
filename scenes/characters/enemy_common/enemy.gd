extends CharacterBody2D
class_name Enemy

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_stunned :=  false
#
#func _ready() -> void:
	#pass
	#
#func _physics_process(delta: float) -> void:
	#pass

func stun():
	print("stun!")
	is_stunned = true
	await get_tree().create_timer(3).timeout
	is_stunned = false
	pass

func on_stun():
	velocity.x = 0
	animation_player.play("stunned")
	await get_tree().create_timer(3)
	
