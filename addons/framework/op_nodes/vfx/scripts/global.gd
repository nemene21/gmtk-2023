extends Node

var time := .0
var player

func _process(delta):
	
	if Engine.is_editor_hint(): return
	
	time += delta
