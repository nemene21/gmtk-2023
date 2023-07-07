extends Area2D

var hits := 0
signal got_hit

func hit(attack : Attack):
	emit_signal("got_hit", attack)
	hits += 1
