extends StaticBody2D

var drag: bool = false
var drag_offset: Vector2 = Vector2()

func _input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        if event.is_pressed() and global_position.distance_to(get_global_mouse_position()) < 100:
            drag = true
            drag_offset = global_position - event.global_position
        else:
            drag = false
    if event is InputEventMouseMotion and drag:
        global_position = event.global_position + drag_offset
