extends GPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play_sound("explode", 1.0, 1.0, 0.2)
