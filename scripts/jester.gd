extends RigidBody2D
   
signal jester_stopped()
signal jester_has_finished()
     
@onready var hasStopped: bool = false

func _ready():
    $Audio.play()

func _process(_delta):
    pass
        
func _integrate_forces(state):
    if !hasStopped:
        var velocity = state.linear_velocity
        if velocity.length() < 0.01:
            for i in range(state.get_contact_count()):
                var collider = state.get_contact_collider_object (i)
                if collider and collider is Node and collider.is_in_group("Ground"):
                    hasStopped = true
                    jester_stopped.emit()
                    break
                if collider and collider is Node and collider.is_in_group("Finish"):
                    hasStopped = true
                    jester_has_finished.emit()
                    break
