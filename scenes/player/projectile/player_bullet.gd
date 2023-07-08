extends CharacterBody2D

@onready var sprite := $sprite

func _physics_process(delta):
	sprite.rotation = velocity.angle()
	move_and_slide()
