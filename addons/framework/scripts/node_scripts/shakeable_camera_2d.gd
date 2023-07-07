extends Camera2D

var shake_animation := .0
var shake_strength  := .0
var direction       := .0
var shake_duration  := .0
var shake_speed     := .0

@export_range(0.0, 1.0) var rotation_amount := .0

var seed  := randf() * 100
var noise := FastNoiseLite.new()

func shake(new_strength : float, new_speed : float, duration : float, new_direction = null):
	
	if shake_strength <= new_strength:
		
		shake_speed = new_speed * 100
		
		if new_direction == null:
			direction = randf() * PI
			
		else:
			direction = deg_to_rad(new_direction)
		
		seed = randf() * 100
		shake_strength = new_strength
		
		shake_animation = 1.0
		
		var tween := get_tree().create_tween()
		tween.tween_property(self, "shake_animation", 0, duration).set_trans(Tween.TRANS_QUAD)
		
		shake_duration = duration
		
func zooming(scale : float, duration : float):
	
	duration *= 0.5
	
	var tween := get_tree().create_tween()
	tween.tween_property(self, "zoom", Vector2(scale, scale), duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)
	
	await get_tree().create_timer(duration).timeout
	
	var new_tween := get_tree().create_tween()
	new_tween.tween_property(self, "zoom", Vector2(1, 1), duration).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)


func _ready(): shake(0.1, 0.1, 0.1)

func _process(delta):
	var noise_value = noise.get_noise_1d(seed + shake_animation * shake_duration * shake_speed) * 2 - 1
	
	offset = Vector2.RIGHT.rotated(direction) * noise_value * shake_strength * sin(shake_animation * PI)
	rotation = offset.x * rotation_amount * 0.01
