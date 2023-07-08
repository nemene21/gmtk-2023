extends Node2D

@onready var sprite := $heart
@onready var shadow := $shadow

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var sine := sin(Global.time * 2 + global_position.x * 2)
	
	sprite.position.y = sine * 3 - 10
