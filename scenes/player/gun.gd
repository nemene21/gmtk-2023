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
	
	AudioManager.play_sound("gun_shoot", 1.0, 1.0, 0.15)
	
	reloaded = false
	
	var difference : Vector2 = get_global_mouse_position() - global_position
	var direction  : Vector2 = difference.normalized()
	
	player.camera.shake(4, 20, 0.1, direction.angle() / PI * 180)
	animation_player.play("shoot")
	VfxManager.play_vfx("player_shoot", barrel.global_position, direction.angle())
	
	var default_stats = player.player_data.default_stats
	var bullet_speed = player.player_data.get_stat_percentage("bullet_speed")
	var spread = deg_to_rad(player.player_data.get_stat_percentage("spread"))
	var firerate = player.player_data.get_stat_percentage("firerate")
	var damage = player.player_data.get_stat_percentage("damage")
	var size = player.player_data.get_stat_percentage("bullet_size")
	
	var friendly_bullets = len(get_tree().get_nodes_in_group("friendly_bullet"))
	damage += player.player_data.get_stat_percentage("damage_per_bullet") * friendly_bullets
	
	if Global.player.hp == 1 and player.player_data.get_stat_percentage("double_damage_when_1hp") > .0:
		damage *= 2
	
	for i in player.player_data.get_stat_percentage("bullet_amount"):
		var bullet := bullet_scene.instantiate()
		bullet.global_position = barrel.global_position
		bullet.velocity = direction.rotated(randf_range(min(0, -spread), max(0, spread))) * bullet_speed
		bullet.damage = damage
		bullet.scale = Vector2(size, size)
		
		reload_timer.start(firerate)
		
		player.add_sibling(bullet)

func _on_reload_timer_timeout():
	reloaded = true
