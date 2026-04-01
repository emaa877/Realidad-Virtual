extends Control

func _ready():
	$abrir.visible   = false
	$agarrar.visible = false
	$dejar.visible   = false
	$advertencia.visible = false
	$quitar.visible = false

func _physics_process(_delta):
	var mensaje = "Resistencias: " + str(var_Globales.inventario["Resistencias"]) + "\nEngranajes: " + str(var_Globales.inventario["Engranajes"])
	$inventario.text = mensaje
	
	if var_Globales.inventario["Resistencias"] == 3 and var_Globales.inventario["Engranajes"] == 3 and var_Globales.objetivos_cumplidos == 0:
		var_Globales.objetivos_cumplidos += 1
		$objetivo.text = "Objetivo:\n* Completar el circuito serie con 3 resistencias"
		$estrella1.texture = load("res://sprites/estrella_llena.png")
	
	elif var_Globales.cant_resistencias_serie == 3 and var_Globales.objetivos_cumplidos == 1:
		var_Globales.objetivos_cumplidos += 1
		$objetivo.text = "Objetivo:\n* Completar el circuito paralelo con 3 resistencias"
		$estrella2.texture = load("res://sprites/estrella_llena.png")
	
	elif var_Globales.cant_resistencias_paralelo == 3 and var_Globales.objetivos_cumplidos == 2:
		var_Globales.objetivos_cumplidos += 1
		$objetivo.text = "Objetivo:\n* Completar el tren de engranajes con los 3 engranajes"
		$estrella3.texture = load("res://sprites/estrella_llena.png")
	
	elif var_Globales.cant_tren_engranajes == 3 and var_Globales.objetivos_cumplidos == 3:
		var_Globales.objetivos_cumplidos += 1
		$objetivo.text = "Objetivos cumplidos !!"
		$estrella4.texture = load("res://sprites/estrella_llena.png")

func _on_Timer_timeout():
	$joystick_mje.visible = false
	$teclado_mje.visible  = false
