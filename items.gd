extends Node
class_name Items

const items = {
	"Allmighty Orb" : {
		"stats" : {
			"damage_per_bullet" : 0.1
		},
		"description" : "The more friendly bullets there are, the more damage you do!"
	}
}

static func new_item(name):
	return items[name].duplicate(true)
