extends Node

func shuffle(array : Array) -> Array:
	var new_array = []
	
	for x in len(array):
		var index = randi_range(0, len(array) - 1)
		new_array.append(array[index])
		array.pop_at(index)
	
	return new_array

func sum(array : Array):
	var n := 0.0
	for element in array:
		n += element
		
	return n

func pick_weighted(values : Array, weights : Array[int]):
	var max_weight = sum(weights)
	var position = randf() * max_weight
	
	var n1 = 0
	for i in len(values):
		var n2 = weights[i]
		
		if position > n1 and position < n1 + n2:
			return values[i]
		
		n1 += n2
