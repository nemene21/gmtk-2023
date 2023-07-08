extends Line2D

@export_range(1, 100) var length := 20;

@onready var point_offset   = position
@onready var parent_position = get_parent().global_position

func _process(delta):
	global_position = Vector2.ZERO
	
	if parent_position != get_parent().global_position:
		parent_position = get_parent().global_position
		
		add_point(parent_position + point_offset)
		
		if get_point_count() > length:
			remove_point(0)
			
	elif get_point_count() != 0:
		remove_point(0)
	
