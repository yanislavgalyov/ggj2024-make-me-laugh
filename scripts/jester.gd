extends RigidBody2D
   
signal jester_stopped()
     
@onready var hasStopped: bool = false

func fire(impulse: Vector2):
    apply_impulse(impulse, Vector2.ZERO)
    print('fire')

func _process(_delta):
    pass
    #print(self.linear_velocity)


func _on_body_entered(body):
    pass
    #if body.is_in_group("Ground"):
        #print(body)
        
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
