extends CharacterBody2D

@export var speed = 200

@onready var flasher := $sprite/flasher
@onready var sprite := $sprite
@onready var move_timer := $move_timer

var vel := Vector2.ZERO
var desired_movement := Vector2.ZERO
var knockback := Vector2.ZERO
var hp : float = 3

signal die

var moving := false
func _ready() -> void:
	AudioManager.call_deferred("play_sound", "enemy_spawn")
	move_timer.wait_time = randf_range(0, 2)
	move_timer.start()

func _process(delta):
	vel = vel.move_toward(desired_movement, delta * 400)
	
	knockback = lerp(knockback, Vector2.ZERO, delta * 4)
	
	velocity = vel + knockback
	move_and_slide()

func hit(attack : Attack):
	hp -= attack.damage
	knockback += attack.knockback
	
	if hp <= 0:
		if is_queued_for_deletion(): return
		
		queue_free()
		
		emit_signal("die")
		
		var body = VfxManager.play_vfx("enemy_body", global_position)
		body.knockback = knockback
		remove_child(sprite)
		body.add_child(sprite)
		flasher.flash(1)
		
		get_parent().spawn_money(randi_range(2, 3), global_position)
		
		AudioManager.play_sound("enemy_kill", 1, 3, 0.2)
	else:
		flasher.flash()
		AudioManager.play_sound("enemy_hit", 1, 3, 0.2)


func _on_move_timer_timeout():
	if moving:
		move_timer.wait_time = randf_range(2, 3)
		desired_movement = Vector2(150, 0).rotated(PI * 2 * randf())
	else:
		desired_movement = Vector2.ZERO
		move_timer.wait_time = 1.5
		$AnimationPlayer.play("shoot")
		
	moving = !moving
	
	move_timer.start()

const bullet_scene := preload("res://scenes/enemies/enemy_bullet.tscn")
func shoot():
	for i in 4:
		var bullet = bullet_scene.instantiate()
		var direction := Vector2(1, 0).rotated(i * PI * 0.5)
		
		bullet.global_position = global_position + direction * 24
		bullet.velocity = direction * 150
		
		add_sibling(bullet)
