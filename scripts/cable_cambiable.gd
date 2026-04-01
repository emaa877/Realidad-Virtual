extends Spatial

const resistencia1 = preload("res://scenes/resistencia_circuito.tscn")
var personaje_entro = false
var quiero_sacar_resist = false
var nueva_resist = resistencia1.instance()
var lugar_ocupado = false

func _physics_process(_delta):
	if self.get_parent().name == "circuito_paralelo":
		$cable.visible = false
	
	#Poniendo resistencias
	if var_Globales.inventario["Resistencias"] > 0 and (var_Globales.joystick["B"]==1 or Input.is_action_just_pressed("key_h")) and personaje_entro and lugar_ocupado==false:
		var_Globales.joystick["B"] = 0
		
		personaje_entro = false
		var_Globales.inventario["Resistencias"] -= 1
		if self.get_parent().name == "circuito_serie":
			var_Globales.cant_resistencias_serie += 1
		elif self.get_parent().name == "circuito_paralelo":
			var_Globales.cant_resistencias_paralelo += 1
		
		nueva_resist = resistencia1.instance()
		get_node("/root/Main/Interfaz/dejar").visible = false
		self.add_child(nueva_resist)
		quiero_sacar_resist = true
		lugar_ocupado = true
	
	#Sacando resistencias
	if (var_Globales.joystick["B"]==1 or Input.is_action_just_pressed("key_h")) and quiero_sacar_resist==true and personaje_entro:
		var_Globales.agarrando_algo = true
		
		quiero_sacar_resist = false
		personaje_entro  = false
		lugar_ocupado = false
		var_Globales.inventario["Resistencias"] += 1
		
		if self.get_parent().name == "circuito_serie":
			var_Globales.cant_resistencias_serie -= 1
		elif self.get_parent().name == "circuito_paralelo":
			var_Globales.cant_resistencias_paralelo -= 1
		
		get_node("/root/Main/Interfaz/quitar").visible = false
		get_node(nueva_resist.name).queue_free()
		#$Timer.start()
 
	if var_Globales.inventario["Resistencias"] == 0 and (var_Globales.joystick["B"]==1 or Input.is_action_just_pressed("key_h")) and personaje_entro:
		get_node("/root/Main/Interfaz/dejar").visible = false
		get_node("/root/Main/Interfaz/advertencia/Label").text = "Sin resistencias"
		get_node("/root/Main/Interfaz/advertencia").visible = true

func _on_area_body_entered(body):
	var_Globales.joystick["B"] = 0
	if body.is_in_group("personaje"):
		personaje_entro = true
		if not lugar_ocupado:
			get_node("/root/Main/Interfaz/dejar").visible = true
		if lugar_ocupado:
			get_node("/root/Main/Interfaz/quitar").visible = true

func _on_area_body_exited(body):
	if body.is_in_group("personaje"):
		personaje_entro = false
		if not lugar_ocupado:
			get_node("/root/Main/Interfaz/dejar").visible = false
		if lugar_ocupado:
			get_node("/root/Main/Interfaz/quitar").visible = false
		
	if var_Globales.inventario["Resistencias"] == 0:
		get_node("/root/Main/Interfaz/advertencia").visible = false

func _on_Timer_timeout():
	pass
