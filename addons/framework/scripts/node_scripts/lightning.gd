@tool
extends Line2D

@export_range(0.0, 64.0) var movement = 32.0
@export_range(0.1, 10.0) var speed = 1.0

var timer = 0.0

func _process(delta):
	timer -= delta * speed
	if timer < 0:
		timer = 0.1
		
		update_points()

func update_points():
	for id in len(points):
		points[id].x = (randf() * 2.0 - 1.0) * movement
