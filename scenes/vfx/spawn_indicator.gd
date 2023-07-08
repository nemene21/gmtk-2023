extends Node2D

var enemy

func dead():
	get_parent().add_child(enemy)
	queue_free()
