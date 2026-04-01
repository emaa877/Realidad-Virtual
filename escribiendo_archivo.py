
import serial, glob

puerto = glob.glob('/dev/ttyUSB*')
print(puerto)
indice_puerto = input("Número de puerto: ") 
arduino = serial.Serial(puerto[int(indice_puerto) - 1]) 

while(True):
    texto = arduino.readline()
    texto = texto.decode("ascii")
    if len(texto)>0:
        f = open("puerto.txt", "w")
        f.write(texto)
        f.close()
