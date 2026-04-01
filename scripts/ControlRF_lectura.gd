extends Spatial

onready var file = 'res://puerto.txt'
var content = ""
var port_file = File.new()

func _ready():
	port_file.open(file, File.READ)
	content = port_file.get_as_text().split('\n')
	port_file.close()

func _physics_process(_delta):
	port_file.open(file, File.READ)
	var texto_puerto = port_file.get_as_text().split('\n')
	port_file.close()
	
	if texto_puerto != content:
		content = texto_puerto
		extrae_variables(content)

func extrae_variables(string_list):
	for cada_string in string_list:
		if len(cada_string)>0:
			if (ord(cada_string[0]) >= 65 and ord(cada_string[0]) <= 72): 
				var numero = cada_string.replace(cada_string[0],'')
				if int(numero)>= 0 and int(numero)<= 255:
					var_Globales.joystick[cada_string[0]] = int(numero)
			
