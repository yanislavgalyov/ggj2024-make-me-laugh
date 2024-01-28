extends RigidBody2D
   
signal jester_stopped(jester_position: Vector2)
signal jester_has_finished(jester_position: Vector2)
     
@onready var hasStopped: bool = false

func _ready():
    $Audio.play()

func _process(_delta):
    if global_position.x > 5000 or global_position.x < -1000 or global_position.y > 2000:
        queue_free()

        
func _integrate_forces(state):
    if !hasStopped:
        var velocity = state.linear_velocity
        if velocity.length() < 0.01:
            for i in range(state.get_contact_count()):
                var collider = state.get_contact_collider_object (i)
                if collider and collider is Node and collider.is_in_group("Ground"):
                    hasStopped = true
                    jester_stopped.emit(global_position)
                    break
                if collider and collider is Node and collider.is_in_group("Finish"):
                    hasStopped = true
                    jester_has_finished.emit(global_position)
                    break
