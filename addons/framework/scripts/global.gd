extends Node

var time := .0

func _process(delta):
	
	if Engine.is_editor_hint(): return
	
	time += delta
