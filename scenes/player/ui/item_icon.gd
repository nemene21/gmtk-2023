extends Node

var item_name

func set_tooltip():
	get_parent().get_parent().get_parent().tooltip.show()
	get_parent().get_parent().get_parent().tooltip.name_tag.text = item_name
	get_parent().get_parent().get_parent().tooltip.description.text = Items.get_item(item_name).description
