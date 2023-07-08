@tool
extends Line2D

var segments = []
var max_length = 0.0

@export var update_segments = false
@export var process_in_editor = true

@export_range(0.0, 96.0, 0.5) var joint_radius = 0.0
@export_color_no_alpha var joint_color = Color(0, 0, 0)

func _ready():
	update()
	
func update():
	segments = []
	max_length = 0
	
	for i in range(1, len(points)):
		var segment = points[i].distance_to(points[i - 1])
		segments.append(segment)
		max_length += segment

func _process(delta):
	
	if Engine.is_editor_hint() and !process_in_editor:
		return
		
	queue_redraw()
	
	if len(points) == 0:
		return
	
	if update_segments:
		update()
		update_segments = false
	
	# FABRIK algorithm
	var max_distance = 0.5
	var max_iterations = 10
	var iteration = 0
	var min_dist = 1
	
	var new_points = points.duplicate()
	
	while iteration < max_iterations:
		
		var on_target = iteration % 2 == 0
		
		var target = $target.position
		var origin = Vector2.ZERO
		
		if target.length() > max_length:
			target -= origin
			target = target.normalized() * max_length
			target += origin
			
		var focus = lerp(origin, target, int(on_target))
		
		new_points[0] = focus
		
		for i in range(1, len(new_points)):
			var dir = new_points[i] - new_points[i - 1]
			dir = dir.normalized() * segments[i - 1]
			new_points[i] = new_points[i - 1] + dir
		
		iteration += 1
		
		if on_target and new_points[len(points) - 1].distance_to(lerp(origin, target, int(!on_target))) < min_dist:
			break

		new_points.reverse()
		segments.reverse()
		
	points = new_points.duplicate()

func _draw():
	for point in points:
		draw_circle(point, joint_radius, joint_color)
