extends Node2D

var tagged := false
var vel := Vector2.ZERO

func _process(delta):
	if global_position.distance_to(Global.player.global_position) < 128 and !tagged:
		tagged = true
		
	if global_position.distance_to(Global.player.global_position) < 32:
		Global.player.money += 1
		queue_free()
		
	if tagged:
		vel = lerp(vel, global_position.direction_to(Global.player.global_position) * 600, delta * 4)
	
	global_position += vel * delta
