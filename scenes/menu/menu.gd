extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play_track("menu")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("space"):
		AudioManager.play_sound("leave_menu")
		PostProcessing.transition_scene("res://scenes/main.tscn")
		
	$Title.position.y = 170 + sin(Global.time * 2) * 16
	
	$player.rotation += delta * 2
	$gun.rotation += delta * 2
	$jetpack.rotation += delta * 2
	
	$player.position += Vector2(sin(Global.time) * delta * 20, sin(Global.time) * delta * 20) * 2
	$gun.position -= Vector2(sin(Global.time * 1.1) * delta * 20, sin(Global.time) * delta * 20) * 2
	$jetpack.position += Vector2(sin(Global.time * 0.75) * delta * 30, sin(Global.time) * delta * 20) * 2
