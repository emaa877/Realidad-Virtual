extends Spatial

var vel_ref = 5.0

func _ready():
	$circuito_paralelo/motor/cable.rotate_y(PI/2)

func _physics_process(_delta):
	match var_Globales.cant_resistencias_serie:
		0:
			$circuito_serie/motor/AnimationPlayer.current_animation = "[stop]"
			$circuito_serie/mensaje_motor/Viewport/Label.text = ""
			$circuito_serie/motor/audio.playing = false
		1:
			$circuito_serie/motor/AnimationPlayer.current_animation = "andando"
			$circuito_serie/motor/AnimationPlayer.playback_speed = vel_ref
			$circuito_serie/mensaje_motor/Viewport/Label.text = "Corriente = 9 mA\nVelocidad = 30 rpm"
			$circuito_serie/motor/audio.pitch_scale = 1.1
			$circuito_serie/motor/audio.playing = true
			
		2: #8-2*resist_serie
			$circuito_serie/motor/AnimationPlayer.playback_speed = vel_ref/2.0
			$circuito_serie/mensaje_motor/Viewport/Label.text = "Corriente = 4.5 mA\nVelocidad = 15 rpm"
			$circuito_serie/motor/audio.pitch_scale = 0.95
		3:
			$circuito_serie/motor/AnimationPlayer.playback_speed = vel_ref/3.0
			$circuito_serie/mensaje_motor/Viewport/Label.text = "Corriente = 3 mA\nVelocidad = 7.5 rpm"
			$circuito_serie/motor/audio.pitch_scale = 0.9
	match var_Globales.cant_resistencias_paralelo:
		0:
			$circuito_paralelo/motor/AnimationPlayer.current_animation = "[stop]"
			$circuito_paralelo/mensaje_motor/Viewport/Label.text = ""
			$circuito_paralelo/motor/audio.playing = false
		1:
			$circuito_paralelo/motor/AnimationPlayer.current_animation = "andando"
			$circuito_paralelo/motor/AnimationPlayer.playback_speed = vel_ref
			$circuito_paralelo/mensaje_motor/Viewport/Label.text = "Corriente = 9 mA\nVelocidad = 30 rpm"
			$circuito_paralelo/motor/audio.playing = true
			$circuito_paralelo/motor/audio.pitch_scale = 1.1
			$circuito_paralelo/motor/audio.unit_size = 1
		2: #8-2*resist_serie
			$circuito_paralelo/motor/AnimationPlayer.playback_speed = vel_ref*2.0
			$circuito_paralelo/mensaje_motor/Viewport/Label.text = "Corriente = 18 mA\nVelocidad = 60 rpm"
			$circuito_paralelo/motor/audio.pitch_scale = 1.2
			$circuito_paralelo/motor/audio.unit_size = 2.5
		3:
			$circuito_paralelo/motor/AnimationPlayer.playback_speed = vel_ref*3.0
			$circuito_paralelo/mensaje_motor/Viewport/Label.text = "Corriente = 27 mA\nVelocidad = 90 rpm"
			$circuito_paralelo/motor/audio.pitch_scale = 1.25
			$circuito_paralelo/motor/audio.unit_size = 4
