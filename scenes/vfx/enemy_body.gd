extends Node2D

var knockback : Vector2

func _process(delta):
	global_position += knockback * delta * 2.0
