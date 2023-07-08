extends Control

#const player_data : PlayerData = preload("res://scenes/player/data.tres")

var player_data = preload("res://scenes/player/data.tres")
@onready var item_display := $Margin/Items

func _ready() -> void:
	player_data.connect("added_item", Callable(self, "display_items"))
	display_items()

func display_items() -> void:
	for child in item_display.get_children():
		child.queue_free()
	
	for item_name in player_data.items:
		var item : Dictionary = Items.items[item_name]
		var texture := TextureRect.new()
		texture.texture = item.texture
		texture.custom_minimum_size = item.texture.get_size() * 2
		item_display.add_child(texture)
