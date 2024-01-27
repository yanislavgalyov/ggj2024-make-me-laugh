extends Node2D

var jester_scene: PackedScene = preload("res://scenes/jester.tscn")
var soft_jester_scene: PackedScene = preload("res://scenes/soft_jester.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if Input.is_action_just_pressed("Reload"):
        TransitionLayer.change_scene(get_tree().current_scene.scene_file_path)
    if Input.is_action_just_pressed("Quit"):
        get_tree().quit()


func _on_cannon_fire_cannon_ball(position: Vector2, impulse: Vector2):
    create_jester_and_fire(position, impulse)

func create_jester_and_fire(position: Vector2, impulse: Vector2)-> void:
    var spawn = soft_jester_scene.instantiate()
    spawn.position = position
    $Projectiles.add_child(spawn)
    $PhantomCamera2D.set_follow_target_node(spawn.get_node("Bone-0"))
    spawn.apply_impulse(Vector2(1000, -200), Vector2.ZERO)
    # spawn.fire(impulse)
    
