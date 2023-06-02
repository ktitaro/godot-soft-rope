extends RigidBody2D

func _draw():
	var pos=Vector2.ZERO
	draw_circle(pos,12,Color.PLUM)

func _physics_process(delta):
	if Input.is_action_just_pressed("action_c"):
		var dir=self.linear_velocity.normalized()
		self.apply_impulse(dir*1000)

