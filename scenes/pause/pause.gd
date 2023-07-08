extends Control

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		visible = !visible
		get_tree().paused = visible
