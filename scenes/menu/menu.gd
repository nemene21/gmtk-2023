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
