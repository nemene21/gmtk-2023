extends Node
class_name Items

const items = {
	"Allmighty Orb" : {
		"stats" : {
			"damage_per_bullet" : 0.1
		},
		"description" : "The more friendly bullets there are, the more damage you do!"
	},
	"Bouncy Substance" : {
		"stats" : {
			"bullet_bounce" : 1
		},
		"description" : "Your bullets bounce off the screen's edges!"
	},
	"Patient Demise" : {
		"stats" : {
			"bullet_slowdown" : 0.5
		},
		"description" : "Bullets will patiently wait to hit something instead of going off-screen!"
	},
	"Silly Shells" : {
		"stats" : {
			"bullet_amount" : 2,
			"spread" : 33
		},
		"description" : "You shoot 2 more bullets but lose accuracy..."
	},
	"Sniper Scope" : {
		"stats" : {
			"bullet_speed" : 2,
			"spread" : 0.25,
			"firerate" : 1.5,
			"damage" : 2
		},
		"description" : "Your shots are more accurate, faster and do more damage, but you shoot much slower..."
	},
	"Void's Edge" : {
		"stats" : {
			"double_damage_when_1hp" : 1
		},
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
