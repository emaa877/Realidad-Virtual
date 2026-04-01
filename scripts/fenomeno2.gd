extends Spatial

func _ready():
	$motorcito/cable.visible = false
	$motorcito/eje/banderita.visible = false
	$tren_engranajes/engranaje1.visible = false
	$tren_engranajes/engranaje2.visible = false
	$tren_engranajes/engranaje3.visible = false

func _physics_process(_delta):
	match var_Globales.cant_tren_engranajes:
		0:
			$tren_engranajes/engranaje1.visible = false
			$tren_engranajes/engranaje2.visible = false
			$tren_engranajes/engranaje3.visible = false
		1:
			$tren_engranajes/engranaje1.visible = true
			$tren_engranajes/engranaje2.visible = false
			$tren_engranajes/engranaje3.visible = false
		2:
			$tren_engranajes/engranaje1.visible = true
			$tren_engranajes/engranaje2.visible = true
			$tren_engranajes/engranaje3.visible = false
		3:
			$tren_engranajes/engranaje1.visible = true
			$tren_engranajes/engranaje2.visible = true
			$tren_engranajes/engranaje3.visible = true
