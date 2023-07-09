extends Control

@onready var bg = $ColorRect

func _ready() -> void:
	visible = false

func toggle_pause() -> void:
	visible = !visible
	get_tree().paused = visible

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_parent().get_parent().enemy_count == 0: return
		
		if !visible:
			toggle_pause()
			position.y = bg.size.y
			var tween = create_tween()
			tween.set_trans(Tween.TRANS_ELASTIC)
			tween.set_ease(Tween.EASE_OUT)
			tween.tween_property(self, "position", Vector2(0, 0), 1)
		else:
			AudioManager.play_sound("leave_menu")
			
			var tween = create_tween()
			tween.set_trans(Tween.TRANS_EXPO)
			tween.set_ease(Tween.EASE_IN)
			tween.tween_property(self, "position", Vector2(0, bg.size.y), 0.2)
			tween.tween_callback(toggle_pause)
