extends RigidBody2D
        
func fire(impulse: Vector2):
    apply_impulse(impulse, Vector2.ZERO)
    print('fire')
