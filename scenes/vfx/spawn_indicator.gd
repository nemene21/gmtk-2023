extends Node2D

var enemy

func dead():
	get_parent().add_child(enemy)
	await(get_tree().create_timer(2).timeout)
	queue_free()
