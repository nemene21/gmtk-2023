extends Node

@onready var parent := get_parent()

@onready var timer := $Timer

func flash(time : float = 0.05, smooth : bool = false):
	if parent.material.get("shader_parameter/flash") != 0:
		return
	
	set_flash_value(1)
	
	timer.wait_time = time
	timer.start()
	
	if smooth:
		create_tween().tween_method(set_flash_value, 1.0, .0, time)


func _on_timer_timeout():
	parent.material.set("shader_parameter/flash", 0)

func set_flash_value(value : float):
	parent.material.set("shader_parameter/flash", value)
