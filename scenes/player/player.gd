extends CharacterBody2D

@export var speed : float = 500
@export var accel : float = 2000
@export var frict : float = 2000

@onready var body_sprite := $body
@onready var flasher := $body/flasher
@onready var gun := $gun_anchor
@onready var camera : Camera2D = get_parent().get_node("camera")

const player_data : PlayerData = preload("res://scenes/player/data.tres")

var money := 0
var hp := 4
var i_frames := .0
signal gain_money
signal player_hit
signal death

func _ready() -> void:
	var items = Items.items.keys()
	items.shuffle()
	for i in 6:
		player_data.add_item(items.pop_front())
	Global.player = self

func _process(delta : float) -> void:
	i_frames -= delta
	
	var input : Vector2 = Input.get_vector("left", "right", "up", "down")
	input = input.normalized()
	
	var accel_delta : float = accel if velocity.dot(input) > 0.5 else frict
	velocity = velocity.move_toward(input * speed, accel_delta * delta)
	
	move_and_slide()
	
	$AnimationPlayer.speed_scale = 1 + abs(velocity.x) / speed * 2
	
	# Turning player
	var mouse_right = get_global_mouse_position().x > global_position.x
	body_sprite.scale.x = lerp(body_sprite.scale.x, (float(mouse_right) * 2 - 1) * 3, delta * 20)
	
	body_sprite.rotation_degrees = velocity.x / speed * 33
	
	# i frame animation
	body_sprite.modulate.a = round(abs(cos(max(0, i_frames) * PI * 8)))

func hit(_attack : Attack):
	if i_frames > 0: return
	
	i_frames = 0.5
	
	create_tween().tween_method(set_vignette_color, Color(1, 0, 0), Color(0, 0, 0), 0.33)
	hp -= 1
	emit_signal("player_hit")
	
	AudioManager.play_sound("player_hit", 1.0, 4.0)
	
	if hp <= 0:
		get_parent().lost()
		hide()
		process_mode = Node.PROCESS_MODE_DISABLED
		emit_signal("death")
		VfxManager.play_vfx("explosion", global_position)
	else:
		flasher.flash()

func set_vignette_color(color : Color):
	PostProcessing.get_node("PostProcessingDraw").material.set("shader_parameter/vignette_color", color)
