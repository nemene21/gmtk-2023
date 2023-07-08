extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("space"):
		PostProcessing.transition_scene("res://scenes/main.tscn")
	
	$player.rotation += delta * 2
	$gun.rotation += delta * 2
	$jetpack.rotation += delta * 2
	
	$player.position += Vector2(sin(Global.time) * delta * 20, sin(Global.time) * delta * 20)
	$gun.position -= Vector2(sin(Global.time * 1.1) * delta * 20, sin(Global.time) * delta * 20)
	$jetpack.position += Vector2(sin(Global.time * 0.75) * delta * 30, sin(Global.time) * delta * 20)
