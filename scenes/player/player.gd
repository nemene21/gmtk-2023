extends CharacterBody2D

@export var speed : float = 500
@export var accel : float = 1000
@export var frict : float = 1000

@onready var body_sprite := $body
@onready var flasher := $body/flasher
@onready var gun := $gun_anchor
@onready var camera : Camera2D = get_parent().get_node("camera")

const player_data : PlayerData = preload("res://scenes/player/data.tres")

func _ready() -> void:
	player_data.add_item("Patient Demise")
	Global.player = self

func _process(delta : float) -> void:
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

func hit(attack : Attack):
	flasher.flash()
