extends Control

#const player_data : PlayerData = preload("res://scenes/player/data.tres")

var player_data = preload("res://scenes/player/data.tres")
@onready var item_display := $Margin/Items

const item_icon_script := preload("res://scenes/player/ui/item_icon.gd")

func _ready() -> void:
	player_data.connect("items_changed", Callable(self, "display_items"))
	display_items()

func display_items() -> void:
	for child in item_display.get_children():
		child.queue_free()
	
	for item_name in player_data.voided_items:
		var item : Dictionary = Items.items[item_name]
		var texture := TextureRect.new()
		texture.texture = item.texture
		texture.modulate.a = 0.25
		texture.custom_minimum_size = item.texture.get_size() * 2
		texture.set_script(item_icon_script)
		texture.item_name = item_name
		texture.connect("mouse_entered", texture.set_tooltip)
		texture.connect("mouse_exited", hide_tooltip)
		item_display.add_child(texture)
	
	for item_name in player_data.items:
		var item : Dictionary = Items.items[item_name]
		var texture := TextureRect.new()
		texture.texture = item.texture
		texture.custom_minimum_size = item.texture.get_size() * 2
		texture.set_script(item_icon_script)
		texture.item_name = item_name
		texture.connect("mouse_entered", texture.set_tooltip)
		texture.connect("mouse_exited", hide_tooltip)
		item_display.add_child(texture)

@onready var tooltip : Node2D = get_parent().get_node("tooltip")

func hide_tooltip() -> void:
	tooltip.hide()
