extends Spatial

var seleccionado = false

func _physics_process(_delta):
	if (var_Globales.joystick["B"]==1 or Input.is_action_just_pressed("key_h")) and seleccionado:
		$Timer.start()
		var_Globales.agarrando_algo = true

func _on_Area_body_entered(body):
	var_Globales.joystick["B"] = 0
	if body.is_in_group("personaje"):
		seleccionado = true
		get_node("/root/Main/Interfaz/agarrar").visible = true

func _on_Area_body_exited(body):
	seleccionado = false
	if body.is_in_group("personaje"):
		seleccionado = false
		get_node("/root/Main/Interfaz/agarrar").visible = false

func _on_Timer_timeout():
	var_Globales.joystick["B"] = 0
	seleccionado = false
	var_Globales.inventario["Engranajes"] += 1
	get_node("/root/Main/Interfaz/agarrar").visible = false
	queue_free()
