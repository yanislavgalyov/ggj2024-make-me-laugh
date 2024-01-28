extends Node2D

signal fire_cannon_ball(pos:Vector2, angle_deg: float, duration: float)

@onready var cannon_sprite : Sprite2D = get_node("Cannon") as Sprite2D
@onready var cannon_marker = get_node("Cannon/Front") as Marker2D

var min_angle_deg : int = -360
var max_angle_deg : int  = 360

var duration: float = 0.0
var is_pressed: bool = false 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if is_pressed:
        duration += delta

    var mouse_pos : Vector2 = get_global_mouse_position()
    var direction : Vector2  = mouse_pos - cannon_sprite.global_position
    var angle_rad : float = atan2(direction.y, direction.x)
    
    var angle_deg : float = rad_to_deg(angle_rad)
    angle_deg = clamp(angle_deg, min_angle_deg, max_angle_deg)
    cannon_sprite.rotation = deg_to_rad(angle_deg)
    
    if Input.is_action_just_pressed("Fire"):
        is_pressed = true
        
    if Input.is_action_just_released("Fire"):
        var clamped_duration = clampf(duration, 0.0, 1.0)
        fire_cannon_ball.emit($Cannon/Front.global_position, angle_deg, clamped_duration) 
        is_pressed = false
        duration = 0.0
