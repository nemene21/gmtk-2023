extends CharacterBody2D

@onready var sprite := $sprite
@onready var hitbox := $hitbox

@export var damage : float = 1

@onready var hp = Global.player.player_data.get_stat_percentage("piercing")
@onready var bounce = Global.player.player_data.get_stat_percentage("bullet_bounce")

func _ready():
	hitbox.attack = Attack.new()
	hitbox.attack.damage = damage
	hitbox.attack.knockback = velocity * 0.2
	
	if Global.player.player_data.get_stat_percentage("fresh_bullets") != 0:
		sprite.modulate = Color("ff5600")
		damage *= 2
		
func _physics_process(delta):
	hitbox.attack.knockback = velocity * 0.2
	
	hitbox.attack.damage = damage
	
	sprite.rotation = velocity.angle()
	move_and_slide()
	
	velocity = lerp(velocity, Vector2.ZERO, delta * 2 * Global.player.player_data.get_stat_percentage("bullet_slowdown"))
	
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
	$AnimationPlayer.play("die")

func _on_cool_off_timeout():
	if Global.player.player_data.get_stat_percentage("fresh_bullets") == 0: return
	
	sprite.modulate = Color(1, 1, 1)
	damage /= 2
