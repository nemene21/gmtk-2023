extends Node2D

@onready var sprite := $heart
@onready var shadow := $shadow

var heart_vel := Vector2.ZERO
var gravity : float = 150
var active := true

func _process(delta):
	
	if active:
		var sine := sin(Global.time * 2 + global_position.x * 2)
		sprite.position.y = sine * 3 - 10
		
	else:
		heart_vel.y += gravity * delta
	
	sprite.position += heart_vel * delta

func destroy():
	heart_vel = Vector2(
		randf_range(-100, 100),
		-randf_range(50, 150)
	)
	active = false
	$AnimationPlayer.play("hit")
