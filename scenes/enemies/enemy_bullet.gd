extends CharacterBody2D

@onready var sprite := $sprite

func _process(delta):
	move_and_slide()
	
	sprite.rotation = velocity.angle()


func _on_hitbox_hit_something():
	queue_free()
