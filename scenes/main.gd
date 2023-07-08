extends Node2D

@onready var camera := $camera

const money_scene := preload("res://scenes/money/money.tscn")

var wave := 1
var enemies := [
	preload("res://scenes/enemies/skeleton/skeleton_enemy.tscn")
]
var enemy_points := [
	100
]

var enemy_count := 0

func _ready():
	VfxManager.set_target(self)
	new_wave()

func spawn_money(amount : int, money_position : Vector2) -> void:
	for i in amount:
		var money := money_scene.instantiate()
		money.global_position = money_position
		add_child(money)

func new_wave():
	var points := 200 * wave + 100
	while points > 0:
		var index : int = randi_range(0, len(enemies) - 1)
		var enemy_scene : PackedScene = enemies[index]
		var cost : int = enemy_points[index]
		
		if points - cost >= 0:
			var enemy = enemy_scene.instantiate()
			enemy.global_position = Vector2(
				randf_range(0, 960),
				randf_range(0, 540)
			)
			
			enemy.connect("die", enemy_died)
			enemy_count += 1

			call_deferred("add_child", enemy)
			
			points -= cost
			
	wave += 1

func enemy_died():
	enemy_count -= 1
	if enemy_count == 0:
		new_wave()
