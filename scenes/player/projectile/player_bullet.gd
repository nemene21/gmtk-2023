extends CharacterBody2D

@onready var sprite := $sprite
@onready var hitbox := $hitbox

func _ready():
	hitbox.attack = Attack.new()
	hitbox.attack.damage = 1
	hitbox.attack.knockback = velocity * 0.2

func _physics_process(delta):
	sprite.rotation = velocity.angle()
	move_and_slide()

func _on_hitbox_hit_something():
	queue_free()
	VfxManager.play_vfx("enemy_hit", global_position, PI + velocity.angle())


func _on_timer_timeout():
	queue_free()
