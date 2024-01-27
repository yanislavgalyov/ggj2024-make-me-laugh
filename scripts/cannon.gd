extends Node2D

signal fire_cannon_ball(pos:Vector2, angle_deg: float)

@onready var cannon_sprite : Sprite2D = get_node("Cannon") as Sprite2D
@onready var cannon_marker = get_node("Cannon/Front") as Marker2D

var min_angle_deg : int = -360
var max_angle_deg : int  = 360

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    var mouse_pos : Vector2 = get_global_mouse_position()
    var direction : Vector2  = mouse_pos - cannon_sprite.global_position
    var angle_rad : float = atan2(direction.y, direction.x)
    
    var angle_deg : float = rad_to_deg(angle_rad)
    angle_deg = clamp(angle_deg, min_angle_deg, max_angle_deg)
    cannon_sprite.rotation = deg_to_rad(angle_deg)
    
    if Input.is_action_just_pressed("Fire"):
        fire_cannon_ball.emit($Cannon/Front.global_position, angle_deg) 
