extends Sprite2D

@onready var animation_player := $AnimationPlayer

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Global.player.gun.connect("shot", spin)
	
func _process(delta):
	global_position = get_global_mouse_position()

func spin():
	animation_player.play("spin")
