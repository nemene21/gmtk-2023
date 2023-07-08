extends CharacterBody2D

@export var speed = 200

@onready var flasher := $sprite/flasher
@onready var sprite := $sprite

var vel := Vector2.ZERO
var knockback := Vector2.ZERO
var hp := 3

signal die

func _process(delta):
	var best_movement : Vector2 = (
		Global.player.global_position - global_position
	).normalized() * speed
	
	vel = vel.move_toward(best_movement, delta * 400)
	
	knockback = lerp(knockback, Vector2.ZERO, delta * 4)
	
	velocity = vel + knockback
	move_and_slide()

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

func hit_player():
	VfxManager.play_vfx("explosion", global_position)
	VfxManager.play_vfx("real_shockwave", global_position, 0, Vector2(4, 4))
	emit_signal("die")
	Global.player.camera.shake(12, 10, 0.3)
	queue_free()
