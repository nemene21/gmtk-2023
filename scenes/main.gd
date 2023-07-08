extends Node2D

@onready var camera := $camera

func _ready():
	VfxManager.set_target(self)
