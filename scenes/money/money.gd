extends Node2D

var tagged := false
@onready var vel := Vector2(randf_range(-200, 200), randf_range(-100, 100))

func _process(delta):
	if global_position.distance_to(Global.player.global_position) < 128 and !tagged:
		tagged = true
		
	if global_position.distance_to(Global.player.global_position) < 32:
		Global.player.money += 10
		Global.player.emit_signal("gain_money", Global.player.money)
		queue_free()
	
	if tagged:
		vel = lerp(vel, global_position.direction_to(Global.player.global_position) * 800, delta * 6)
	else:
		vel = lerp(vel, Vector2.ZERO, delta * 2)
		
	global_position += vel * delta
