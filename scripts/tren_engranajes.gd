extends Spatial

var quiero_poner_tren = false
var quiero_sacar_tren = false

func _physics_process(_delta):
	if (var_Globales.joystick["B"]==1 or Input.is_action_just_pressed("key_h")) and quiero_sacar_tren and var_Globales.cant_tren_engranajes>0:
		var_Globales.joystick["B"] = 0
		var_Globales.inventario["Engranajes"] += 1
		var_Globales.cant_tren_engranajes -= 1
		get_node("/root/Main/Interfaz/quitar").visible = false
	
	elif var_Globales.inventario["Engranajes"] > 0 and (var_Globales.joystick["B"]==1 or Input.is_action_just_pressed("key_h")) and quiero_poner_tren and not quiero_sacar_tren:
		var_Globales.joystick["B"] = 0 
		var_Globales.inventario["Engranajes"] -= 1
		var_Globales.cant_tren_engranajes += 1
		if var_Globales.inventario["Engranajes"] == 0: 
			get_node("/root/Main/Interfaz/dejar").visible = false
 
	if var_Globales.inventario["Engranajes"] == 0 and (var_Globales.joystick["B"]==1 or Input.is_action_just_pressed("key_h")) and quiero_poner_tren:
		get_node("/root/Main/Interfaz/dejar").visible = false
		get_node("/root/Main/Interfaz/advertencia/Label").text = "Sin engranajes"
		get_node("/root/Main/Interfaz/advertencia").visible = true
		
func _on_Area_poner_body_entered(body):
	var_Globales.joystick["B"] = 0
	if body.is_in_group("personaje"):
		quiero_poner_tren = true
		get_node("/root/Main/Interfaz/dejar").visible = true

func _on_Area_poner_body_exited(body):
	if body.is_in_group("personaje"):
		get_node("/root/Main/Interfaz/dejar").visible = false
		quiero_poner_tren = false
	if var_Globales.inventario["Engranajes"] == 0:
		get_node("/root/Main/Interfaz/advertencia").visible = false

func _on_Area_sacar_body_entered(body):
	var_Globales.joystick["B"] = 0
	if body.is_in_group("personaje") and var_Globales.cant_tren_engranajes != 0:
		get_node("/root/Main/Interfaz/quitar").visible = true
		quiero_sacar_tren = true

func _on_Area_sacar_body_exited(body):
	if body.is_in_group("personaje"):
		get_node("/root/Main/Interfaz/quitar").visible = false
		quiero_sacar_tren = false
	if var_Globales.cant_tren_engranajes == 0:
		get_node("/root/Main/Interfaz/advertencia").visible = false
