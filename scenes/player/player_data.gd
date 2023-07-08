extends Resource
class_name PlayerData

var items : Array[String] = []

var default_stats := {
	"damage_per_bullet" : 0.0,
	"damage" : 1,
	"bullet_amount" : 1,
	"bullet_bounce" : 1,
	"bullet_slowdown" : 1,
	"bullet_speed" : 1000.0,
	"firerate" : 0.2,
	"spread" : 0.0,
	"bullet_size" : 1.0,
	"piercing" : 0.0,
}

var stat_modifiers := {
	"damage_per_bullet" : 0.0,
	"damage" : 1.0,
	"bullet_amount" : 0,
	"bullet_bounce" : 0,
	"bullet_slowdown" : 1.0,
	"bullet_speed" : 1.0,
	"firerate" : 1.0,
	"spread" : 1.0,
	"bullet_size" : 1.0,
	"piercing" : 0,
}

func add_item(name : String) -> void:
	items.append(name)

func get_stat_modifier(name : String):
	assert(name in stat_modifiers.keys())
	var value = stat_modifiers[name]
	if typeof(value) == TYPE_BOOL:
		for item_name in items:
			var item = Items.items[item_name]
			if not item.stats.has(name):
				continue
			if item.stats[name] == true:
				return true
	elif typeof(value) == TYPE_FLOAT or typeof(value) == TYPE_INT:
		for item_name in items:
			var item = Items.items[item_name]
			if not item.stats.has(name):
				continue
			value += item.stats[name]
		print("%s: %d" % [name, value])
	
	return value

func get_stat_percentage(name : String) -> float:
	var value = get_stat_modifier(name)
	assert(typeof(value) == TYPE_FLOAT or typeof(value) == TYPE_INT)
	return default_stats[name] * value

func get_stat_boolean(name : String) -> bool:
	var value = get_stat_modifier(name)
	assert(typeof(value) == TYPE_BOOL)
	return value
