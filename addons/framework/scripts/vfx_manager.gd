extends Node

var vfx = {}
var target = null

var kill_timer = preload("res://addons/framework/op_nodes/kill_timer.tscn")

func _ready():
	add_vfx("shockwave", "res://addons/framework/op_nodes/vfx/shockwave.tscn")
	add_vfx("real_shockwave", "res://addons/framework/op_nodes/vfx/realistic_shockwave.tscn")

func set_target(new_target):
	target = new_target

func add_vfx(name : String, path : String):
	vfx[name] = load(path)
	
func play_vfx(name : String, pos : Vector2, rot : float = 0.0, scale : Vector2 = Vector2(1, 1), duration : float = 5.0):
	var vfx_node = vfx[name].instantiate()
	
	vfx_node.global_position = pos
	vfx_node.rotation = rot
	vfx_node.scale = scale
	
	if vfx_node is GPUParticles2D:
		vfx_node.emitting = true
		
	var kill_timer_node = kill_timer.instantiate()
	kill_timer_node.wait_time = duration
	vfx_node.add_child(kill_timer_node)
		
	target.add_child(vfx_node)
	
	return vfx_node

func spring_physics(value, target, delta_v, strength, damping):
	var delta_t = get_physics_process_delta_time()
	
	var force = strength * (target - value) - damping * delta_v
	delta_v += force * delta_t
	value   += delta_v
	
	return {"value" : value, "delta" : delta_v}

func slowdown(ratio : float = 0.5, time : float = 0.5):
	create_tween().tween_property(Engine, "time_scale", ratio, time * 0.5)
	await get_tree().create_timer(time * 0.5).timeout
	create_tween().tween_property(Engine, "time_scale", 1, time * 0.5)

func frame_freeze(time : float = 0.5):
	get_tree().paused = true
	await get_tree().create_timer(time).timeout
	get_tree().paused = false
