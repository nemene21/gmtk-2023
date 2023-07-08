extends Node2D

@onready var gun_sprite := $ak
@onready var reload_timer := $reload_timer
@onready var animation_player := $AnimationPlayer
@onready var flasher := $ak/flasher
@onready var barrel := $ak/barrel

@onready var player : CharacterBody2D = get_parent()

const bullet_scene := preload("res://scenes/player/projectile/player_bullet.tscn")
var reloaded := true
signal shot

func _process(delta):
	var difference : Vector2 = get_global_mouse_position() - global_position
	rotation = lerp_angle(rotation, difference.angle(), delta * 16)
	
	gun_sprite.scale.y = int(get_global_mouse_position().x > global_position.x) * 2 - 1
	
	show_behind_parent = get_global_mouse_position().y < global_position.y
	
	if Input.is_action_pressed("shoot") and reloaded:
		shoot()

func shoot():
	emit_signal("shot")
	animation_player.play("shoot")
	
	reloaded = false
	reload_timer.start()
	
	var difference : Vector2 = get_global_mouse_position() - global_position
	var direction  : Vector2 = difference.normalized()
	
	player.camera.shake(4, 20, 0.1, direction.angle())
	
	var bullet := bullet_scene.instantiate()
	bullet.global_position = barrel.global_position
	bullet.velocity = direction * 1000
	
	player.get_parent().add_child(bullet)

func _on_reload_timer_timeout():
	reloaded = true
