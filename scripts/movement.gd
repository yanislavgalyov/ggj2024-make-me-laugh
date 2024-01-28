extends Marker2D

@export var speed = 1000

func get_input(delta):
    var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
    var direction = input_direction * speed * delta
    translate(direction)

func _process(delta):
    get_input(delta)
