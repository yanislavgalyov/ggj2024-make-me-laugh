extends Node2D

signal soft_body_stopped()

@onready var soft: SoftBody2D = $Soft as SoftBody2D
@onready var bone: RigidBody2D = $"Soft/Bone-0"

@onready var hasStopped: bool = false
@onready var ground_ray: RayCast2D = $GroundRay

var previous_position: Vector2

func _ready():
    previous_position = bone.global_position
    $Audio.play()
    
func _physics_process(delta):
    if !hasStopped:
        var diff = bone.global_position - previous_position        
        var on_ground: bool = false
        
        if ground_ray.is_colliding():
            var collider = ground_ray.get_collider()
            if collider is Node:
                if collider.is_in_group("Ground"):
                    on_ground = true
                    
        if on_ground and diff.length_squared() < 1.0:
            hasStopped = true
            soft_body_stopped.emit()
            
        previous_position = bone.global_position
