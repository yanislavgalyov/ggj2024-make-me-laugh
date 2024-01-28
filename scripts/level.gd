extends Node2D

@export var force: float = 1000

var jester_scene: PackedScene = preload("res://scenes/jester.tscn")
var soft_jester_scene: PackedScene = preload("res://scenes/soft_jester.tscn")
var rock_scene: PackedScene = preload("res://scenes/rock.tscn")
var dialogue_scene: PackedScene = preload("res://scenes/dialogue.tscn")

@onready var follow_camera = $FollowCamera
@onready var free_camera = $FreeMarker/FreeCamera

@onready var cannon = $Cannon
@onready var projectiles = $Projectiles
@onready var obstacles = $Obstacles
    
func _process(_delta):
    if Input.is_action_just_pressed("Reset Camera"):
        switch_cameras()
    if Input.is_action_just_pressed("Reload"):
        TransitionLayer.change_scene(get_tree().current_scene.scene_file_path)
    if Input.is_action_just_pressed("Quit"):
        TransitionLayer.change_scene("res://scenes/menu.tscn")
    if Input.is_action_just_pressed("Spawn"):
        var spawn = rock_scene.instantiate()
        spawn.position = get_global_mouse_position()
        obstacles.add_child(spawn)
        
func switch_cameras():
    var follow_camera_priority: int = follow_camera.get_priority()
    var free_camera_priority: int = free_camera.get_priority()
    
    if follow_camera_priority > free_camera_priority:
        switch_to_free_camera()
    else:
        switch_to_follow_camera(cannon)
        
        
func switch_to_follow_camera(target): 
    free_camera.set_priority(0)    
    follow_camera.set_follow_target_node(target)
    follow_camera.set_priority(20)
    
func switch_to_free_camera():
    follow_camera.set_priority(0)
    free_camera.set_priority(20)    

func _on_soft_body_stopped()-> void:
    var spawn = dialogue_scene.instantiate()
    projectiles.add_child(spawn)
    
func _on_jester_stopped()-> void:
    var spawn = dialogue_scene.instantiate()
    projectiles.add_child(spawn)
    
func _on_jester_has_finished()-> void:
    TransitionLayer.change_scene(get_tree().current_scene.scene_file_path)

func _on_cannon_fire_cannon_ball(pos: Vector2, angel_deg: float)-> void:
    create_jester_and_fire(pos, angel_deg, false)

func create_jester_and_fire(pos: Vector2, angel_deg: float, is_soft: bool)-> void:
    if is_soft:
        var spawn = soft_jester_scene.instantiate()
        spawn.position = pos
        projectiles.add_child(spawn)
        spawn.connect("soft_body_stopped", _on_soft_body_stopped)
        var soft = spawn.get_node("Soft")
        switch_to_follow_camera(soft.get_node("Bone-0"))
        
        var angle_rad: float = deg_to_rad(angel_deg)
        var direction: Vector2 = Vector2(cos(angle_rad), sin(angle_rad))
        var impulse: Vector2 = direction.normalized() * force
        
        soft.apply_impulse(impulse, Vector2.ZERO)
    else:
        var spawn = jester_scene.instantiate()
        spawn.position = pos
        projectiles.add_child(spawn)
        spawn.connect("jester_stopped", _on_jester_stopped)
        spawn.connect("jester_has_finished", _on_jester_has_finished)
        switch_to_follow_camera(spawn)

        var angle_rad: float = deg_to_rad(angel_deg)
        var direction: Vector2 = Vector2(cos(angle_rad), sin(angle_rad))
        var impulse: Vector2 = direction.normalized() * force
        
        spawn.apply_impulse(impulse, Vector2.ZERO)
        
    
