extends Node2D

@onready var sprite := $money
@onready var shadow := $shadow
@onready var label := $Label

var money_displayed : float = 0
var money_lerp_to : float = 0

func _process(delta):
	var sine := sin(Global.time * 2 + global_position.x * 2)
	
	sprite.position.y = sine * 3 - 10
	
	money_displayed = lerp(money_displayed, money_lerp_to, delta * 3)
	label.text = str(ceil(money_displayed))
	
	label.position.y = lerp(label.position.y, -20.0, delta * 6)
	
	if global_position.distance_to(Global.player.global_position) < 128:
		modulate.a = lerp(modulate.a, 0.25, 5 * delta)
	else:
		modulate.a = lerp(modulate.a, 1.0, 5 * delta)
	sprite.material.set_shader_parameter("alpha", modulate.a)


func _on_player_gain_money(money : int):
	money_lerp_to = money
	label.position.y = -26
