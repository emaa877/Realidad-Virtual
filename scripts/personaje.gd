extends KinematicBody

const GRAVITY = 2
const SPEED = 2.5
var direction = Vector3(0,-1,0)

func _physics_process(delta):
	var t = get_transform()
	if Input.is_action_pressed("ui_down"):
		t.origin += t.basis.z * SPEED *delta
		set_transform(t)
	elif Input.is_action_pressed("ui_up"):
		t.origin -= t.basis.z * SPEED *delta
		set_transform(t)
		
	if Input.is_action_pressed("ui_left"):
		rotate_object_local(Vector3(0,1,0),deg2rad(1))
	elif Input.is_action_pressed("ui_right"):
		rotate_object_local(Vector3(0,1,0),deg2rad(-1))
		
	move_and_collide(direction)
