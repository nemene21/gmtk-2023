extends ColorRect


var target := Vector2(0.5, 0.5)
var velocity := Vector2()
var current_position := target

func _process(delta: float) -> void:
	if current_position.distance_to(target) < 0.01:
		target = Vector2(randf(), randf())
	
	velocity = velocity.move_toward(current_position.direction_to(target) * 0.05, 0.05 * delta)
	current_position += velocity * delta
	material.set_shader_parameter("hole_position", current_position)
