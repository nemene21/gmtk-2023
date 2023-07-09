extends CharacterBody2D

@onready var sprite := $sprite
@onready var hitbox := $hitbox

@export var damage := 1

@onready var hp = Global.player.player_data.get_stat_percentage("piercing")
@onready var bounce = Global.player.player_data.get_stat_percentage("bullet_bounce")

func _ready():
	hitbox.attack = Attack.new()
	hitbox.attack.damage = damage
	hitbox.attack.knockback = velocity * 0.2

func _physics_process(delta):
	sprite.rotation = velocity.angle()
	move_and_slide()
	
	if (global_position.x < 0 or global_position.x > 960) and bounce > 0:
		bounce -= 1
		velocity.x *= -1
		move_and_slide()
		
	if (global_position.y < 0 or global_position.y > 540) and bounce > 0:
		bounce -= 1
		velocity.y *= -1
		move_and_slide()

func _on_hitbox_hit_something():
	hp -= 1
	VfxManager.play_vfx("enemy_hit", global_position, PI + velocity.angle())
	if hp < 0:
		queue_free()
	

func _on_timer_timeout():
	queue_free()
