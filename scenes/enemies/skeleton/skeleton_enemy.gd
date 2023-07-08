extends CharacterBody2D

@export var speed = 200

@onready var flasher := $sprite/flasher
@onready var sprite := $sprite

var vel := Vector2.ZERO
var knockback := Vector2.ZERO
var hp := 3

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
		
		var body = VfxManager.play_vfx("enemy_body", global_position)
		body.knockback = knockback
		remove_child(sprite)
		body.add_child(sprite)
		flasher.flash(1)
		
	else:
		flasher.flash()
