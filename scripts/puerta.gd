extends Spatial
var entered = false
var door_opened = false

func _physics_process(_delta):
	if (var_Globales.joystick["A"]==1 or Input.is_action_just_pressed("key_g")) and entered==true: 
		var_Globales.joystick["A"] = 0
		$AnimationPlayer.current_animation = "puerta_abriendo"
		entered = false
		door_opened = true
		get_node("/root/Main/Interfaz/abrir").visible = false

func _on_Area_body_entered(body):
	var_Globales.joystick["A"] = 0
	if body.is_in_group("personaje"):
		entered = true
		get_node("/root/Main/Interfaz/abrir").visible = true

func _on_Area_body_exited(body):
	entered = false
	if body.is_in_group("personaje"):
		if door_opened:
			$AnimationPlayer.current_animation = "puerta_cerrando"
			door_opened = false
		get_node("/root/Main/Interfaz/abrir").visible = false
