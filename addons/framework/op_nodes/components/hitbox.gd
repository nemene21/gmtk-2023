extends Area2D

var hits := 0
signal hit_something

@export var attack : Attack

func _on_area_entered(area):
	if get_parent().is_queued_for_deletion(): return
	
	if area.is_in_group("hurtbox"):
		hits += 1
		emit_signal("hit_something")
		area.hit(attack)
