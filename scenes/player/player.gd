extends CharacterBody2D

@export var speed : float = 170
@export var accel : float = 3
@export var frict : float = 5

func _ready() -> void:
	pass

func _process(delta : float) -> void:
	var input : Vector2 = Input.get_vector("left", "right", "up", "down")
	input = input.normalized()
	
	var accel_delta : float = accel if velocity.dot(input) > 0.5 else frict
	velocity = velocity.move_toward(input * speed, accel_delta * delta)
	
	move_and_slide()
