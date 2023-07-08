extends Node
class_name Items

const items : Dictionary = {
	"Allmighty Orb" : {
		"stats" : {
			"damage_per_bullet" : 0.1
		},
		"texture" : preload("res://scenes/items/almightyorb.png"),
		"description" : "The more friendly bullets there are, the more damage you do!"
	},
	"Bouncy Substance" : {
		"stats" : {
			"bullet_bounce" : 1
		},
		"texture" : preload("res://scenes/items/bouncysubstance.png"),
		"description" : "Your bullets bounce off the screen's edges!"
	},
	"Patient Demise" : {
		"stats" : {
			"bullet_slowdown" : 1
		},
		"texture" : preload("res://scenes/items/patientdemise.png"),
		"description" : "Bullets will patiently wait to hit something instead of going off-screen!"
	},
	"Silly Shells" : {
		"stats" : {
			"bullet_amount" : 2,
			"spread" : 33
		},
		"texture" : preload("res://scenes/items/silshell.png"),
		"description" : "You shoot 2 more bullets but lose accuracy..."
	},
	"Sniper Scope" : {
		"stats" : {
			"bullet_speed" : 600,
			"spread" : -33,
			"firerate" : -0.5,
			"damage" : 10
		},
		"texture" : preload("res://scenes/items/sniperscope.png"),
		"description" : "Your shots are more accurate, faster and do more damage, but you shoot much slower..."
	},
	"Void's Edge" : {
		"stats" : {
			"double_damage_when_1hp" : 1
		},
		"texture" : preload("res://scenes/items/voidsedge.png"),
		"description" : "The adrenaline makes you do double damage when on 1 HP!?"
	}
}

static func get_item(name : String) -> Dictionary:
	var item = items[name]
	return item

static func random_item_name() -> String:
	var item_keys = items.keys()
	return item_keys[
		round( randf() * len(item_keys) )
	]
