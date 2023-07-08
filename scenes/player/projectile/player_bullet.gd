extends CharacterBody2D

@onready var sprite := $sprite
@onready var hitbox := $hitbox

@export var damage := 1

func _ready():
	hitbox.attack = Attack.new()
	hitbox.attack.damage = damage
	hitbox.attack.knockback = velocity * 0.2

func _physics_process(delta):
	sprite.rotation = velocity.angle()
	move_and_slide()

func _on_hitbox_hit_something():
	queue_free()
	VfxManager.play_vfx("enemy_hit", global_position, PI + velocity.angle())


func _on_timer_timeout():
	queue_free()
