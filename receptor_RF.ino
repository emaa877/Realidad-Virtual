#include <RF24_config.h>
#include <nRF24L01.h>
#include <RF24.h>
#include <printf.h>

RF24 radio(9, 10);   // nRF24L01 (CE, CSN)
const byte address[6] = "00001";
unsigned long lastReceiveTime = 0;
unsigned long currentTime = 0;

byte j1X_ant = 127;
byte j1Y_ant = 127;
byte j2X_ant = 123;
byte j2Y_ant = 127;

const int J_RANGO_DIF = 2;

struct Actualiza_datos{
  bool ant = false;
  bool act = false;
};
Actualiza_datos boton1;
Actualiza_datos boton2;
Actualiza_datos boton3;
Actualiza_datos boton4;
Actualiza_datos hay_datos; //para recibir el flanco de subida y de bajada 

struct Data_Package { //El maximo tamanio para esta estructura es 32bytes - NRF24L01 limite del buffer
  byte j1PotX;
  byte j1PotY;
  byte j1Button;
  byte j2PotX;
  byte j2PotY;
  byte j2Button;
  byte pot1;
  byte pot2;
  byte tSwitch1;
  byte tSwitch2;
  byte button1;
  byte button2;
  byte button3;
  byte button4;
};
Data_Package data; //Crea una variable con toda la estructura
Data_Package datos_locales;

void setup() {
  Serial.begin(9600);
  radio.begin();
  radio.openReadingPipe(0, address);
  radio.setAutoAck(false);
  radio.setDataRate(RF24_250KBPS);
  radio.setPALevel(RF24_PA_LOW);
  radio.startListening(); //Setea el modulo como receptor
  resetData();
}

void loop() { //Codificacion: Boton 1: A; Boton 2: B; Boton 3: C; Boton 4: D; J1X: E; J1Y: F; J2X: G; J2Y: H
  botones();
  joysticks();
    
  verifica_conex();
  sonido_conex();

  actualizar_datos();
  delay(17); //Frecuencia physics process Godot:60times per second -> 1/60 = 17ms
}

void actualizar_datos(){
  boton1.ant = boton1.act;
  boton2.ant = boton2.act;
  boton3.ant = boton3.act;
  boton4.ant = boton4.act;
  j1X_ant = datos_locales.j1PotX;
  j1Y_ant = datos_locales.j1PotY;
  j2X_ant = datos_locales.j2PotX;
  j2Y_ant = datos_locales.j2PotY;
  hay_datos.ant = hay_datos.act;
}

void botones(){
  if (data.button1) boton1.act=false;       //por defecto esta en alto
  else if (data.button1==0 && !boton1.ant){ //si se apreto el boton y antes no estaba apretado
   boton1.act = true;
   Serial.println("A1");
  }

  if (data.button2) boton2.act=false;
  else if (data.button2 ==0 && !boton2.ant){
    boton2.act = true;
    Serial.println("B1");
  }
  if (data.button2==1 && boton2.ant){
    Serial.println("B0");
  }

  if (data.button3) boton3.act=false;
  else if (data.button3 ==0 && !boton3.ant){
    boton3.act = true;
    Serial.println("D1");
  }

  if (data.button4) boton4.act=false;
  else if (data.button4 ==0 && !boton4.ant){
    boton4.act = true;
    Serial.println("C1");
  }
 }

void joysticks(){
  datos_locales.j1PotX = data.j1PotX;
  datos_locales.j1PotY = data.j1PotY;
  datos_locales.j2PotX = data.j2PotX;
  datos_locales.j2PotY = data.j2PotY;
  
 if (!(datos_locales.j1PotX < (j1X_ant+J_RANGO_DIF) && datos_locales.j1PotX > (j1X_ant-J_RANGO_DIF))){ 
    Serial.print("E");
    Serial.println(datos_locales.j1PotX); 
  }
  
  if (!(datos_locales.j1PotY < (j1Y_ant+J_RANGO_DIF) && datos_locales.j1PotY > (j1Y_ant-J_RANGO_DIF))){      
    Serial.print("F");
    Serial.println(datos_locales.j1PotY); 
  }
  
  if (!(datos_locales.j2PotX < (j2X_ant+J_RANGO_DIF) && datos_locales.j2PotX > (j2X_ant-J_RANGO_DIF))){ 
    Serial.print("G");
    Serial.println(datos_locales.j2PotX); 
  }

  if (!(datos_locales.j2PotY < (j2Y_ant+J_RANGO_DIF) && datos_locales.j2PotY > (j2Y_ant-J_RANGO_DIF))){ 
    Serial.print("H");
    Serial.println(datos_locales.j2PotY); 
  }
}

void resetData() {
  data.j1PotX = 127;
  data.j1PotY = 127;
  data.j2PotX = 123;
  data.j2PotY = 127;
  data.j1Button = 1;
  data.j2Button = 1;
  data.pot1 = 1;
  data.pot2 = 1;
  data.tSwitch1 = 1;
  data.tSwitch2 = 1;
  data.button1 = 1;
  data.button2 = 1;
  data.button3 = 1;
  data.button4 = 1;
}

void verifica_conex(){
  if (radio.available()) {
    radio.read(&data, sizeof(Data_Package)); 
    lastReceiveTime = millis();               
    hay_datos.act = true;
  }
  currentTime = millis();
  if ( currentTime - lastReceiveTime > 1000 ) { 
    resetData(); 
    hay_datos.act = false;
  }
}

void sonido_conex(){
  if (hay_datos.ant == true && hay_datos.act == false){ 
    for (int i=0;i<3;i++){
      tone(7,5000,60); 
      delay(300);
    }
  }
  if (hay_datos.ant == false && hay_datos.act == true){ 
    tone(7,5000,30); 
    delay(150);
    tone(7,5000,30);
  }
}

