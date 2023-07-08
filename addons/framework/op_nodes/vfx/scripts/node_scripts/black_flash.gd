extends Timer

func _ready():
	get_parent().modulate = Color(0, 0, 0)


func _on_timeout():
	get_parent().modulate = Color(1, 1, 1)
	queue_free()
