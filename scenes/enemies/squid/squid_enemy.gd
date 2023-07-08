extends CharacterBody2D

@onready var direction := int(randf()) * 2 - 1

@onready var shoot_timer := $shoot_timer
@onready var sprite := $sprite
@onready var flasher := $sprite/flasher
@onready var animation_player := $AnimationPlayer
@onready var barrel := $sprite/barrel

var knockback := Vector2.ZERO
var hp = 3

signal die

const bullet_scene := preload("res://scenes/enemies/enemy_bullet.tscn")

func _ready():
	$shoot_delay_timer.wait_time = randf_range(0, 1)
	$shoot_delay_timer.start()

func _process(delta):
	var vel : Vector2 = (
		global_position - Global.player.global_position
	).rotated(0.5*PI).normalized() * direction * 100
	
	knockback = lerp(knockback, Vector2.ZERO, delta * 4)
	
	velocity = knockback + vel
	move_and_slide()
	
	sprite.look_at(Global.player.global_position)
	sprite.rotation_degrees -= 90

func hit(attack : Attack):
	hp -= attack.damage
	knockback += attack.knockback
	
	if hp <= 0:
		queue_free()
		
		emit_signal("die")
		
		var body = VfxManager.play_vfx("enemy_body", global_position)
		body.knockback = knockback
		remove_child(sprite)
		body.add_child(sprite)
		flasher.flash(1)
		
		get_parent().spawn_money(randi_range(2, 3), global_position)
		
	else:
		flasher.flash()

func shoot_start():
	animation_player.play("shoot")

func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = barrel.global_position
	bullet.velocity = Vector2.RIGHT.rotated(sprite.rotation + 0.5*PI) * 150
	add_sibling(bullet)

func _on_shoot_delay_timer_timeout():
	shoot_timer.start()
