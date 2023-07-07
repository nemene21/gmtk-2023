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
		"description" : "Your bullets bounce off the screens edges!"
	},
	"Patient Demise" : {
		"stats" : {
			"bullet_slowdown" : 1
		},
		"description" : "Bullets will patiently wait to hit something instead of going off-screen!"
	}
}

static func new_item(name : String) -> Dictionary:
	return items[name].duplicate(true)
