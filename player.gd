extends CharacterBody2D

var max_speed=200
var accl=max_speed/10
var fric=max_speed/20

func _init():
	self.motion_mode=1

func _draw():
	var pos=Vector2.ZERO
	draw_circle(pos,10,Color.PINK)

func _physics_process(delta):
	var dir=self._get_input_vec()
	if (dir!=Vector2.ZERO): self._speed_up(dir)
	if (dir==Vector2.ZERO): self._slow_down(dir)
	move_and_slide()

func _get_input_vec():
	var dir=Vector2.ZERO
	if Input.is_action_pressed("ui_up"): dir.y-=1
	if Input.is_action_pressed("ui_down"): dir.y+=1
	if Input.is_action_pressed("ui_left"): dir.x-=1
	if Input.is_action_pressed("ui_right"): dir.x+=1
	return dir.normalized()

func _speed_up(dir):
	if (dir.x!=0): self.velocity.x+=accl*dir.x
	if (dir.y!=0): self.velocity.y+=accl*dir.y
	self.velocity=self.velocity.clamp(
		Vector2(max_speed,max_speed)*-1,
		Vector2(max_speed,max_speed))

func _slow_down(dir):
	var x=self.velocity.x; var y=self.velocity.y
	if (x!=0 and x<0): self.velocity.x=min(x+fric,0)
	if (x!=0 and x>0): self.velocity.x=max(x-fric,0)
	if (y!=0 and y<0): self.velocity.y=min(y+fric,0)
	if (y!=0 and y>0): self.velocity.y=max(y-fric,0)
