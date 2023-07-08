extends Node
class_name Items

const items = {
	"Allmighty Orb" : {
		"stats" : {
			"damage_per_bullet" : -0.1
		},
		"description" : "The more [rainbow]friendly[/rainbow] bullets there are, the more damage you do!"
	},
	"Bouncy Substance" : {
		"stats" : {
			"bullet_bounce" : 1
		},
		"description" : "Your bullets [wave]bounce[/wave] off the screen's edges!"
	},
	"Patient Demise" : {
		"stats" : {
			"bullet_slowdown" : -0.5
		},
		"description" : "Bullets will [wave]patiently wait[/wave] to hit something instead of going off-screen!"
	},
	"Silly Shells" : {
		"stats" : {
			"bullet_amount" : 2,
			"spread" : 33
		},
		"description" : "You shoot two more bullets but lose accuracy..."
	},
	"Sniper Scope" : {
		"stats" : {
			"bullet_speed" : 1,
			"spread" : -0.25,
			"firerate" : 0.5,
			"damage" : 1
		},
		"description" : "Your shots are more accurate, faster and do more damage, but you shoot much slower..."
	},
	"Void's Edge" : {
		"stats" : {
			"double_damage_when_1hp" : 1
		},
		"description" : "The adrenaline makes you do [wave]double damage[/wave] when on 1 HP!?"
	},
	"Sharp Nail" : {
		"stats" : {
			"piercing" : 1
		},
		"texture" : preload("res://scenes/items/nailitem.png"),
		"description" : "Bullets [shake]pierce[/shake] trough an additional enemy (ouch)"
	},
	"Big Bullet" : {
		"stats" : {
			"bullet_size" : 0.5,
			"bullet_speed" : 0.0
		},
		"texture" : preload("res://scenes/items/bulletitem.png"),
		"description" : "Bullets are [shake]larger[/shake], but slower..."
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
