extends Node2D

@onready var camera := $camera
@onready var item_repair := $ui/ItemRepair

const money_scene := preload("res://scenes/money/money.tscn")

var wave := 1
var enemies := [
	preload("res://scenes/enemies/skeleton/skeleton_enemy.tscn"),
	preload("res://scenes/enemies/ship/ship_enemy.tscn"),
	preload("res://scenes/enemies/squid/squid_enemy.tscn")
]
var enemy_points := [
	100,
	100,
	100
]

var enemy_count := 0

var game_over := false

func _ready():
	VfxManager.set_target(self)
	new_wave()
	camera.shake(16, 15, 1)
	AudioManager.play_track("battle")
	$Player.connect("death", lost)

func spawn_money(amount : int, money_position : Vector2) -> void:
	for i in amount:
		var money := money_scene.instantiate()
		money.global_position = money_position
		add_child(money)

func new_wave():
	if wave == 15:
		won()
		return
		
	var points := 200 * wave + 100
	
	AudioManager.play_sound("wave_start")
	
	while points > 0:
		var index : int = randi_range(0, len(enemies) - 1)
		var enemy_scene : PackedScene = enemies[index]
		var cost : int = enemy_points[index]
		
		if points - cost >= 0:
			var enemy = enemy_scene.instantiate()
			enemy.global_position = Vector2(
				randf_range(64, 960 - 64),
				randf_range(64, 540 - 64)
			)
			
			enemy.connect("die", enemy_died)
			enemy_count += 1
			
			var indicator = VfxManager.play_vfx("enemy_spawn", enemy.global_position, 0, Vector2(3, 3), 5)
			indicator.enemy = enemy
			
			points -= cost
			
	wave += 1
	
	# Remove an item from the player every 3 waves
	if wave % 2 == 1:
		var player_data = Global.player.player_data
		player_data.void_item()
		item_repair.update_and_show(player_data.voided_items.back())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if event.is_action_pressed("restart") and game_over:
		Global.player.player_data.items.clear()
		Global.player.player_data.voided_items.clear()
		get_tree().reload_current_scene()

func enemy_died():
	enemy_count -= 1
	if enemy_count == 0:
		new_wave()

func lost():
	$ui/GameOver/Text.text = "You lost!"
	$ui/AnimationPlayer.play_backwards("in")
	$ui/winlose_animator.play("done")
	game_over = true

func won():
	$ui/GameOver/Text.text = "You won!"
	$ui/AnimationPlayer.play_backwards("in")
	$ui/winlose_animator.play("done")
	game_over = true
