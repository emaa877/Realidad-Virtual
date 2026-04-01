extends Spatial

const resistencia = preload("res://scenes/resistencia.tscn")
const engranaje =   preload("res://scenes/engranaje.tscn")
var pos_objetos = [ Vector3(-10.5, 0,   7.6), Vector3(-11.3,  0,  -0.5),
					Vector3(-14.3, 0,  17.5), Vector3(  5.4,  0,  17.8),
					Vector3( 16.5, 0,  11.6), Vector3( 17.7,  0,   6.8),
					Vector3( 17.8, 0,   0.7), Vector3( 10.5,  0, -13.8),
					Vector3(  4.8, 0, -17.2), Vector3(-13.5,  0,  -6.8),
					Vector3( -7.2, 0, -16.4), Vector3(  3.8,  0,  -7.0)]
var obj_agregados = []
const cant_resist = 3
const cant_eng    = 3

func _ready():
	randomize()
	agregar_objetos(engranaje,cant_eng)
	agregar_objetos(resistencia,cant_resist)

func agregar_objetos(obj,num):
	for i in range(num):
		var nuevo_obj = obj.instance()
		var indice = randi()%len(pos_objetos)
		while(indice in obj_agregados):
			indice = randi()%len(pos_objetos)
		
		obj_agregados.append(indice)
		nuevo_obj.translate(pos_objetos[indice])
		nuevo_obj.rotate_y(deg2rad(randi()%180))
		self.add_child(nuevo_obj)

