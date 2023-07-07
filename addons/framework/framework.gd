@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("AudioManager", "res://addons/framework/scripts/audio_manager.gd")
	add_autoload_singleton("VfxManager", "res://addons/framework/scripts/vfx_manager.gd")
	add_autoload_singleton("Global", "res://addons/framework/singletons/Global.tscn")
	add_autoload_singleton("Random", "res://addons/framework/scripts/random.gd")
	add_autoload_singleton("PostProcessing", "res://addons/framework/singletons/PostProcessCanvas.tscn")


func _exit_tree():
	remove_autoload_singleton("AudioManager")
	remove_autoload_singleton("VfxManager")
	remove_autoload_singleton("Global")
	remove_autoload_singleton("PostProcessing")
	remove_autoload_singleton("Random")
