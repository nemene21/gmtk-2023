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
	
	if global_position.distance_to(Global.player.global_position) < 128:
		modulate.a = lerp(modulate.a, 0.25, 5 * delta)
	else:
		modulate.a = lerp(modulate.a, 1.0, 5 * delta)

	sprite.material.set_shader_parameter("alpha", modulate.a)

func destroy():
	heart_vel = Vector2(
		randf_range(-100, 100),
		-randf_range(50, 150)
	)
	active = false
	$AnimationPlayer.play("hit")
