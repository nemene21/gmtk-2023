extends Node2D

func player_hit():
	get_child(Global.player.hp).destroy()
