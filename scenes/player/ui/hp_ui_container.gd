extends Node2D

func _on_player_player_hit():
	get_child(Global.player.hp).destroy()
