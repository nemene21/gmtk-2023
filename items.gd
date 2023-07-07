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
			"bullet_slowdown" : 1
		},
		"description" : "Bullets will patiently wait to hit something instead of going off-screen!"
	},
	"Silly Shells" : {
		"stats" : {
			"bullet_amount" : 2,
			"spread" : 33
		},
		"description" : "You shoot 2 more bullets but loose accuracy..."
	},
	"Sniper Scope" : {
		"stats" : {
			"bullet_speed" : 600,
			"spread" : -33,
			"firerate" : -0.5,
			"damage" : 10
		},
		"description" : "You shoot 2 more bullets but loose accuracy..."
	}
}

static func new_item(name : String) -> Dictionary:
	var item = items[name].duplicate(true)
	item.name = name
	return item
