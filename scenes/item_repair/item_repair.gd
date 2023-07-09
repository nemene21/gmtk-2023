extends Control

@onready var bg = $ColorRect
@onready var info = %Info
@onready var item_lost_label = %ItemLost
@onready var items_container = %Items

var label_settings : LabelSettings
var last_voided_item : String
var warning : Label

func _ready() -> void:
	label_settings = LabelSettings.new()
	label_settings.font_color = Color.YELLOW
	visible = false

func unpause() -> void:
	Global.in_gui = false
	visible = false
	get_tree().paused = false

func close() -> void:
	AudioManager.play_sound("leave_menu")
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", Vector2(0, bg.size.y), 0.2)
	tween.tween_callback(unpause)

func repair_item(button : Button, item_name : String) -> void:
	var player_data = Global.player.player_data
	player_data.voided_items.erase(item_name)
	player_data.add_item(item_name)
	Global.player.money -= Items.items[item_name].repair_cost
	
	player_data.emit_signal("items_changed")
	Global.player.emit_signal("gain_money", Global.player.money)
	
	update(last_voided_item)

func update(voided_item : String) -> void:
	last_voided_item = voided_item
	var player_data = Global.player.player_data
	item_lost_label.text = "You lost the %s!" % voided_item.to_lower()
	for button in items_container.get_children():
		if button.name != "Nothing":
			button.queue_free()
	for item_name in player_data.voided_items:
		var item = Items.items[item_name]
		var cost = item.repair_cost
		if Global.player.money - cost < 0:
			continue
		var button = Button.new()
		button.text = "%s for %d" % [item_name.to_lower(), item.repair_cost]
		button.icon = item.texture
		button.pressed.connect(repair_item.bind(button, item_name))
		items_container.add_child(button)
		items_container.move_child(button, 0)
		
	if is_instance_valid(warning):
		warning.queue_free()
	if items_container.get_child_count() == 0:
		warning = Label.new()
		warning.label_settings = label_settings
		warning.text = "You have no items you can repair :("
		warning.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		info.add_child(warning)

func update_and_show(voided_item : String) -> void:
	Global.in_gui = true
	update(voided_item)
	visible = true
	get_tree().paused = true
	
	position.y = bg.size.y
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(0, 0), 1)
