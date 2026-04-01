extends KinematicBody

const VEL_MAX = 0.03
const RANGO_SUP = 130
const RANGO_INF = 126
const VEL = 75           #velocidad del personaje hacia adelante y atras

func _physics_process(delta):
	movimiento(delta)
	if var_Globales.agarrando_algo:
		$brazos/AnimationPlayer.play("ArmatureAction001")
		var_Globales.agarrando_algo = false

func velocidad(x):
	var vel = -235.29e-6 * float(x) + VEL_MAX
	return vel

func movimiento(delta):
	var t = get_transform()
	
	#Movimiento con joystick
	if var_Globales.joystick["F"]<RANGO_INF or var_Globales.joystick["F"]>RANGO_SUP:
		t.origin += t.basis.z * velocidad(var_Globales.joystick["F"]) * VEL * delta
		set_transform(t)
		
	if var_Globales.joystick["G"]<RANGO_INF-3 or var_Globales.joystick["G"]>RANGO_SUP:
		rotate_object_local(Vector3(0,1,0),velocidad(var_Globales.joystick["G"]+3)*-0.65) #0.58
		
	#Movimiento con teclado
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("key_w"):
		t.origin -= t.basis.z * VEL * VEL_MAX * delta
		set_transform(t)
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("key_s"):
		t.origin += t.basis.z * VEL * VEL_MAX * delta
		set_transform(t)
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("key_a"):
		rotate_object_local(Vector3(0,1,0),-VEL_MAX*-0.65) #0.58
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("key_d"):
		rotate_object_local(Vector3(0,1,0),VEL_MAX*-0.65) 
	
	move_and_collide(Vector3(0,-1,0))
