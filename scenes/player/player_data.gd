extends Resource
class_name PlayerData

var items : Array[String] = []

func add_item(name : String) -> void:
	items.append(name)
